#!/bin/bash

automount="UUID=$(blkid -s UUID -o vakue /dev/sdb1) /mnt/newdisk ext4 noexec,noatime 0 2"
echo $automount >> /etc/fstab

reboot

#check

mount | grep newdisk
touch /mnt/newdisk/test.sh && chmod +x /mnt/newdisk/test.sh
./mnt/newdisk/test.sh

# must return permission error

