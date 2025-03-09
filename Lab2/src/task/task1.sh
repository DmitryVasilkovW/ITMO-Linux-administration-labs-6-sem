#!/bin/bash

fdisk /dev/sdb <<EOF
n
p
1

+500M
w
EOF
