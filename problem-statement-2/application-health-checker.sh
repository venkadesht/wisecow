#!/bin/bash

# Application Health Checker
# AccuKnox DevOps Trainee - Problem Statement 2

URL="${1:-https://127.0.0.1:9443}"
HOST_HEADER="wisecow.local"
LOG_FILE="application-health.log"

echo "========================================" | tee -a "$LOG_FILE"
echo "Application Health Check" | tee -a "$LOG_FILE"
echo "Date: $(date)" | tee -a "$LOG_FILE"
echo "URL: $URL" | tee -a "$LOG_FILE"
echo "========================================" | tee -a "$LOG_FILE"

HTTP_STATUS=$(curl -k -L -s \
    -o /dev/null \
    -w "%{http_code}" \
    -H "Host: $HOST_HEADER" \
    --connect-timeout 10 \
    "$URL")

if [[ "$HTTP_STATUS" =~ ^2[0-9][0-9]$ ]]; then
    echo "Application Status: UP" | tee -a "$LOG_FILE"
    echo "HTTP Status Code: $HTTP_STATUS" | tee -a "$LOG_FILE"
    exit 0

elif [[ "$HTTP_STATUS" =~ ^3[0-9][0-9]$ ]]; then
    echo "Application Status: UP (Redirect)" | tee -a "$LOG_FILE"
    echo "HTTP Status Code: $HTTP_STATUS" | tee -a "$LOG_FILE"
    exit 0

else
    echo "Application Status: DOWN" | tee -a "$LOG_FILE"
    echo "HTTP Status Code: $HTTP_STATUS" | tee -a "$LOG_FILE"
    exit 1
fi
