#!/bin/bash

ls -Fal /etc > ~/test/list &
pid=$!

wait $pid

if [ $? -ne 0 ]; then
    echo "ls exit with error $?"
    exit 1
fi
