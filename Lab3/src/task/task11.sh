#!/bin/bash

sudo apt update
sudo apt install apt-rdepends

apt-rdepends gcc | grep Depends > task11.log

