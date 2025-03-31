#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <PID>"
    exit 1
fi

CG_DIR="/sys/fs/cgroup/cpu_auto"
sudo mkdir -p "$CG_DIR"

if ps -p "$1" > /dev/null; then
    echo "$1" | sudo tee "$CG_DIR/cgroup.procs" >/dev/null || {
        echo "Failed to add process to cgroup. Trying alternative method..."
        echo "$1" | sudo tee "/sys/fs/cgroup$(cat /proc/$1/cgroup | head -1 | cut -d: -f3)/cgroup.procs" >/dev/null
    }
else
    echo "Process $1 does not exist"
    exit 1
fi

while true; do
    USAGE=$(mpstat 1 1 | awk '/Average:/ {printf "%.0f", 100 - $NF}')

    if ! [[ "$USAGE" =~ ^[0-9]+$ ]]; then
        echo "Error getting CPU usage"
        sleep 5
        continue
    fi

    if [ "$USAGE" -lt 20 ]; then
        echo "80000 100000" | sudo tee "$CG_DIR/cpu.max" >/dev/null
        echo "Low load (<20%): Set CPU quota to 80%"
    elif [ "$USAGE" -gt 60 ]; then
        echo "30000 100000" | sudo tee "$CG_DIR/cpu.max" >/dev/null
        echo "High load (>60%): Set CPU quota to 30%"
    else
        echo "Normal load ($USAGE%): Keeping current CPU quota"
    fi

    sleep 5
done
