#!/bin/bash

echo user >> work3.log
cat /etc/passwd | grep "u1" | awk 'BEGIN{FS=":"} {print $1, $3}' >> work3.log
echo groups >> work3.log
cat /etc/group | grep "u1" | awk 'BEGIN{FS=":"} {print $1, $3}' >> work3.log
