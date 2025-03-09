#!/bin/bash

umount /dev/sdb1
e2fsck -n /dev/sdb1
mount /dev/sdb1 /mnt/newdisk
