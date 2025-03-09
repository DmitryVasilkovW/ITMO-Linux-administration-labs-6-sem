#!/bin/bash

sudo sh -c 'echo "deb [trusted=yes] file:/root/localrepo ./" > /etc/apt/sources.list.d/localrepo.list'
sudo apt update
