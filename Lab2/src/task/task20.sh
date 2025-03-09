#!/bin/bash

apt install -y nfs-kernel-server
systemctl enable --now nfs-server
