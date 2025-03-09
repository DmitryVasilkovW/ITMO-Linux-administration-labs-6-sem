#!/bin/bash

blkid /dev/sdb1 | awk -f '"' '{print $2}' > /root/uuid.txt
