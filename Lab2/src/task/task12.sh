#!/bin/bash

echo -e "n\np\n2\n\n+12M\nw" | fdisk /dev/sdb

wipefs --all /dev/sdb2

mke2fs -O journal_dev -b 4096 /dev/sdb2

tune2fs -O ^has_journal /dev/sdb1

tune2fs -J device=/dev/sdb2 /dev/sdb1

dumpe2fs /dev/sdb1 | grep -i journal
