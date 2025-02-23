#!/bin/bash

groups_list=$(cut -d: -f1 /etc/group | paste -sd, -)
echo "Groups: $groups_list" >> work3.log
