#!/bin/bash

getent group | cut -d : -f1 | sed -z 's/\n/,/g;s/,$/\n/' >> work3.log
