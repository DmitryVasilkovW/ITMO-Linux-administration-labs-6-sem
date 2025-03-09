#!/bin/bash

fdisk /dev/sdb <<EOF
d
n
p
1

+1G
w
EOF

resize2ds /dev/sdb1

#check

df -h /mnt/newdisk
