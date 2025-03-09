#!/bin/bash

pvcreate /dev/sde
vgextend myvg /dev/sde
lvextend -l +100%FREE /dev/myvg/mylv
