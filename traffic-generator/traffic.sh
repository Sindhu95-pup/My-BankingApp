#!/bin/sh

echo "🚀 Starting traffic generator..."
while true; do
  AMOUNT=$(( (RANDOM % 3000) + 100 ))
  RESPONSE=$(curl -s -X POST http://handler:9091/api/v1/transactions \
    -H "Content-Type: application/json" \
    -d "{\"amount\": $AMOUNT, \"currency\": \"EUR\", \"merchantId\": \"M123\"}")
  echo "[TrafficGen] Sent txn amount=$AMOUNT → Response: $RESPONSE"
  sleep 5
done