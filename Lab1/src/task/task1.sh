#!/bin/bash

awk -F: '{ print "user",$1,"has id", $3 }' /etc/passwd > work3.log
