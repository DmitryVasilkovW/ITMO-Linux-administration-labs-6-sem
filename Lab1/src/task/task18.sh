#!/bin/bash

echo 'u1 ALL=(ALL) NOPASSWD: /usr/bin/passwd [A-Za-z0-9_-]*' | sudo tee -a /etc/sudoers > /dev/null

