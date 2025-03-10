#!/bin/bash

blkid /dev/sdb1 | awk -F '"' '{print $2}' > /root/uuid.txt
