#!/bin/bash

pvcreate /dev/sdc /dev/sdb
vgcreate myvg /dev/sda /dev/sdb
lvcreate -i 2 -l 100%FREE -n mylv myvg
mkfs.ext4 /dev/myvg/mylv
