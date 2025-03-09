#!/bin/bash

apt-get source nano
cd nano-*

mkdir -p debian/nano/usr/bin
ln -s nano debian/nano/usr/bin/newnano

dpkg-buildpackage -us -uc
sudo dpkg -i ../nano_*.deb
newnano --version

