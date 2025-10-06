#!/bin/bash
set -e

PID_FILE="$(dirname "$0")/processor.pid"

if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    echo "🛑 Stopping Processor (PID: $PID)..."
    kill $PID
    rm "$PID_FILE"
    echo "✅ Processor stopped."
else
    echo "⚠️ No processor.pid file found. Is the processor running?"
fi