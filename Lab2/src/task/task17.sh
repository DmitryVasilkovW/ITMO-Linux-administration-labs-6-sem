#!/bin/bash

pvcreate /dev/sde
vgextend myvg /dev/sde
lvextend -l1 +100%FREE /dev/myvg/mylv
