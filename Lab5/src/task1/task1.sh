#!/usr/bin

sudo useradd -m user-67
sudo systemctl set-property user-$(id -u user-67).slice CPUQuota=50%
