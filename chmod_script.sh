#!/bin/bash

pattern="task"
from=$2
to=$3
path=$1

if [ -z "$path" ] || [ -z "$from" ] || [ -z "$to" ]; then
    echo "Error: File path not specified!"
    echo "Usage: $0 /path/to/files"
    exit 1
fi

for ((i=from; i<=to; i++)); do
    file="${path}/${pattern}${i}.sh"
    if [ -f "$file" ]; then
        chmod +x "$file"
        echo "exec chmod +x $file"
    else
        echo "not found: $file"
    fi
done
