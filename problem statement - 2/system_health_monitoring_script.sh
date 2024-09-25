#!/bin/bash

# Define thresholds
CPU_THRESHOLD=80.0     # CPU usage threshold (%)
MEM_THRESHOLD=80.0     # Memory usage threshold (%)
DISK_THRESHOLD=80      # Disk usage threshold (%)
PROCESS_THRESHOLD=300  # Maximum number of processes

# To check CPU usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
    
if (( $(echo "$cpu_usage > $CPU_THRESHOLD" | bc -l) )); then
    echo "$(date): High CPU usage detected: ${cpu_usage}%" | tee -a monitoring.log
fi

# To check memory usage
mem_usage=$(free | grep Mem | awk '{print $7/$2 * 100}')
    
if (( $(echo "$mem_usage > $MEM_THRESHOLD" | bc -l) )); then
    echo "$(date): High memory usage detected: ${mem_usage}%" | tee -a monitoring.log
fi

# To check disk usage
disk_usage=$(df | awk '$NF == "/" {print $5}' | sed 's/%//')
    
if (( disk_usage > DISK_THRESHOLD )); then
    echo "$(date): High disk usage detected: ${disk_usage}%" | tee -a monitoring.log
fi

# To check number of running processes
process_count=$(ps aux | wc -l)
  
if (( process_count > PROCESS_THRESHOLD )); then
    echo "$(date): High number of running processes detected: ${process_count}" | tee -a monitoring.log
fi
