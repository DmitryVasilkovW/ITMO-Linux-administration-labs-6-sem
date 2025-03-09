#!/bin/bash

task="/mnt/vol01 10.0.2.0/24(rw,sync,no_subtree_check,no_root_squash)"
echo $task >> /etc/exports

exportfs -ra
