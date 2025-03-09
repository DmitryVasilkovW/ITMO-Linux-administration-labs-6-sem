#!/bin/bash

mkdir -p /var/remotenfs
mount -t nfs -o rw,vers=4 10.0.2.15:/mnt/vol01 /var/remotenfs
