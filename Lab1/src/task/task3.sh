#!/bin/bash

dir_count=$(find /etc -type d | wc -l)
hidden_file_count=$(find /etc -type f -name ".*" | wc -l)

echo "$dir_count" >> ~/test/list
echo "$hidden_file_count" >> ~/test/list
