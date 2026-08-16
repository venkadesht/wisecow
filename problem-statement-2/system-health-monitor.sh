#!/bin/bash

CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80

LOG_FILE="system-health.log"

echo "========================================" | tee -a "$LOG_FILE"
echo "System Health Check" | tee -a "$LOG_FILE"
echo "Date: $(date)" | tee -a "$LOG_FILE"
echo "Hostname: $(hostname)" | tee -a "$LOG_FILE"
echo "========================================" | tee -a "$LOG_FILE"


CPU_USAGE=$(top -bn1 | awk '/Cpu\(s\)/ {print 100 - $8}' | cut -d. -f1)

echo "CPU Usage: ${CPU_USAGE}%" | tee -a "$LOG_FILE"

if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
    echo "ALERT: CPU usage is above ${CPU_THRESHOLD}%" | tee -a "$LOG_FILE"
else
    echo "CPU usage is normal." | tee -a "$LOG_FILE"
fi

MEMORY_USAGE=$(free | awk '/Mem:/ {printf "%.0f", ($3/$2)*100}')

echo "Memory Usage: ${MEMORY_USAGE}%" | tee -a "$LOG_FILE"

if [ "$MEMORY_USAGE" -gt "$MEMORY_THRESHOLD" ]; then
    echo "ALERT: Memory usage is above ${MEMORY_THRESHOLD}%" | tee -a "$LOG_FILE"
else
    echo "Memory usage is normal." | tee -a "$LOG_FILE"
fi


DISK_USAGE=$(df / | awk 'NR==2 {gsub("%",""); print $5}')

echo "Disk Usage: ${DISK_USAGE}%" | tee -a "$LOG_FILE"

if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    echo "ALERT: Disk usage is above ${DISK_THRESHOLD}%" | tee -a "$LOG_FILE"
else
    echo "Disk usage is normal." | tee -a "$LOG_FILE"
fi


PROCESS_COUNT=$(ps aux --no-headers | wc -l)

echo "Running Processes: $PROCESS_COUNT" | tee -a "$LOG_FILE"

echo "System health check completed." | tee -a "$LOG_FILE"
echo "========================================" | tee -a "$LOG_FILE"
