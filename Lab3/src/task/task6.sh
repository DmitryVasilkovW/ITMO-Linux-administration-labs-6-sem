#!/bin/bash

mkdir ~/src_bastet && cd ~/src_bastet

sudo apt-get install dpkg-dev
sudo sed -i '/^# deb-src /s/^# //' /etc/apt/sources.list
sudo apt update

apt-get source bastet
