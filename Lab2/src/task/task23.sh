#!/bin/bash

df -h | grep remotenfs
touch /var/remotenfs/testfile
