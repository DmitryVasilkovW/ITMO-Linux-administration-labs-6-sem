#!/bin/bash

cat /etc/group | grep "g1" | awk 'BEGIN{FS=":"} {print $1, $3}' >> work3.log
