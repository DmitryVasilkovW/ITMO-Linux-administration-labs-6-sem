#!/bin/bash

if ! getent group task14 > /dev/null; then
    groupadd task14
fi

usermod -a -G task14 u1
usermod -a -G task14 u2

chown u1:task14 /home/test13
chown u1:task14 /home/test13/work3-1.log /home/test13/work3-2.log

chmod 750 /home/test13
chmod 640 /home/test13/work3-1.log /home/test13/work3-2.log

