#!/bin/bash

PID_FILE="$(dirname "$0")/handler.pid"

if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    echo "🛑 Stopping Handler (PID: $PID)..."
    kill $PID
    rm "$PID_FILE"
    echo "✅ Handler stopped."
else
    echo "⚠️ No handler.pid file found. Is the handler running?"
fi