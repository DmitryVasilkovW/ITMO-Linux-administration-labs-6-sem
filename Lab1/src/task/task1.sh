#!/bin/bash

rm -f work3.log

awk -F: '{ print "user",$1,"has id", $3 }' /etc/passwd > work3.log
