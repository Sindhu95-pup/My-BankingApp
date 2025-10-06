package main

import (
	"encoding/json"
	"log"
	"net/http"
	"os"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

var (
	totalRequests = prometheus.NewCounter(
		prometheus.CounterOpts{
			Name: "processor_requests_total",
			Help: "Total number of requests received",
		},
	)
	nokRequests = prometheus.NewCounter(
		prometheus.CounterOpts{
			Name: "processor_requests_nok_total",
			Help: "Total number of requests rejected (NOK)",
		},
	)
)

func init() {
	prometheus.MustRegister(totalRequests)
	prometheus.MustRegister(nokRequests)
	os.MkdirAll("/app/logs", os.ModePerm)
}

type Transaction struct {
	Amount     float64 `json:"amount"`
	Currency   string  `json:"currency"`
	MerchantId string  `json:"merchantId"`
}

type Response struct {
	Status string `json:"status"`
}

func processHandler(w http.ResponseWriter, r *http.Request) {
	totalRequests.Inc()
	var tx Transaction
	if err := json.NewDecoder(r.Body).Decode(&tx); err != nil {
		log.Printf("❌ Invalid request: %v", err)
		http.Error(w, "Invalid request", http.StatusBadRequest)
		return
	}

	var status string
	if tx.Amount <= 1000 {
		status = "OK"
	} else {
		status = "NOK"
	}

	// Log the request + decision
	log.Printf("📥 Received transaction: amount=%.2f, currency=%s, merchantId=%s -> Decision=%s",
		tx.Amount, tx.Currency, tx.MerchantId, status)

	resp := Response{Status: status}
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(resp)
}

func main() {
	// ✅ Configure file logging at startup
	f, err := os.OpenFile("/app/logs/processor.log",
		os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		log.Fatal(err)
	}
	log.SetOutput(f)
	http.Handle("/metrics", promhttp.Handler())
	http.HandleFunc("/process", processHandler)
	log.Println("Processor service running on :9090")
	//log.Fatal(http.ListenAndServe(":9090", nil))
	if err := http.ListenAndServe(":9090", nil); err != nil {
		log.Fatal(err)
	}
}
