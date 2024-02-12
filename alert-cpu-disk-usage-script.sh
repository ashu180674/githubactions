#!/bin/bash

#thresholds
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80


log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

#CPU usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'.' -f1)
if [ "$cpu_usage" -gt "$CPU_THRESHOLD" ]; then
    log "High CPU usage detected! Current CPU usage: $cpu_usage%"
fi

#memory usage
memory_usage=$(free | awk '/Mem:/ {print $3/$2 * 100.0}')
if [ "$(printf '%.0f' "$memory_usage")" -gt "$MEMORY_THRESHOLD" ]; then
    log "High memory usage detected! Current memory usage: $memory_usage%"
fi

#disk space
disk_usage=$(df -h | awk '$NF=="/" {print $5}' | sed 's/%//')
if [ "$disk_usage" -gt "$DISK_THRESHOLD" ]; then
    log "High disk usage detected! Current disk usage: $disk_usage%"
fi

#running processes
process_count=$(ps aux --no-heading | wc -l)
if [ "$process_count" -gt 100 ]; then
    log "High number of running processes detected! Current process count: $process_count"
fi
