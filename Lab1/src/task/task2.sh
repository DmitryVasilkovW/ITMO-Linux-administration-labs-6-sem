#!/bin/bash

echo "Root password last changed on: $(chage -l root | grep "Last password change" | awk '{print $5, $6, $7}')" >> work3.log
