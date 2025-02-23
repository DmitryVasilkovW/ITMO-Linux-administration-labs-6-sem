#!/bin/bash

echo "u1 ALL=(root) NOPASSWD: /usr/bin/passwd" > /etc/sudoers.d/u1-passwd
chmod 440 /etc/sudoers.d/u1-passwd

