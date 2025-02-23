#!/bin/bash

users_in_g1=$(getent group g1 | awk -F: '{print $4}')

echo "Users in group g1: $users_in_g1" >> work3.log

