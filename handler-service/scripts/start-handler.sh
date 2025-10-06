#!/bin/bash
set -e

# Go to handler-service root (where pom.xml lives)
cd "$(dirname "$0")/.."   # this moves up from scripts/ to handler-service/

echo "🚀 Starting Handler Service..."
#mvn clean package -DskipTests
java -jar target/handler-service-0.0.1-SNAPSHOT.jar \
  --server.port=9091 \
  --processor.url=http://localhost:9090/process > logs/handler-console.log 2>&1 &
echo $! > scripts/handler.pid
echo "✅ Handler started on port 9091 (PID: $(cat scripts/handler.pid))"