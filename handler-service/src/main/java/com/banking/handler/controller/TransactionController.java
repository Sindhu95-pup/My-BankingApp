package com.banking.handler.controller;

import com.banking.handler.model.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import jakarta.annotation.PostConstruct;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/v1")
public class TransactionController {

    private static final Logger log = LoggerFactory.getLogger(TransactionController.class);

    private final RestTemplate restTemplate = new RestTemplate();

    // Processor URL (can be set via env var in Docker/K8s)
    //@Value("${processor.url:http://localhost:9090/process}")
    //private String processorUrl;

    @Value("${processor.url}")
    private String processorUrl;
    @PostConstruct
    public void init() {
    log.info("Processor URL configured as: {}", processorUrl);
    }
    @PostMapping("/transactions")
public ResponseEntity<?> handleTransaction(@RequestBody Transaction tx) {
    log.info("📥 Received transaction request: amount={}, currency={}, merchantId={}",
             tx.getAmount(), tx.getCurrency(), tx.getMerchantId());

    try {
        ResponseEntity<Map> response = restTemplate.postForEntity(
                processorUrl, tx, Map.class);

        log.info("📤 Sent to processor at {} -> Response: {}", processorUrl, response.getBody());
        return ResponseEntity.ok(response.getBody());

    } catch (Exception e) {
        log.error("❌ Error calling processor", e);
        Map<String, String> error = new HashMap<>();
        error.put("status", "ERROR");
        error.put("message", e.getMessage());
        return ResponseEntity.internalServerError().body(error);
    }
}
}
