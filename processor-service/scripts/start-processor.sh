#!/bin/bash
set -e

# Go to processor-service root
cd "$(dirname "$0")/.."

echo "🚀 Starting Processor Service..."
#go build -o processor
./processor > scripts/processor.log 2>&1 &
echo $! > scripts/processor.pid
echo "✅ Processor started on port 9090 (PID: $(cat scripts/processor.pid))"