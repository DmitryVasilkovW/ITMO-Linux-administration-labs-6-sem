#!/bin/bash

fdisk /dev/sdb <<EOF
n
p
1

+5G
w
EOF

mkfs.ext4 /dev/sdb1

mkdir -p /mnt/mydata
