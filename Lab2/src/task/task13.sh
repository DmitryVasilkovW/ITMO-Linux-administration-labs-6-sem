#!/bin/bash

for disk in /dev/sdc /dev/sdd; do
	fdisk $disk <<EOF
	n
	p
	1

	w
	EOF
	pvcreate "${disk}1"
done
