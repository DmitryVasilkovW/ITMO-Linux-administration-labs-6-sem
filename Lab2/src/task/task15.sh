#!/bin/bash

mkdir -p /mnt/vol01
echo "/dev/myvg/mylv /mnt/vol01 ext4 defaults 0 0" >> /etc/fstab
mount -a
