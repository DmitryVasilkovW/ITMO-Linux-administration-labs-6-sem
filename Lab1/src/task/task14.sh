#!/bin/bash

usermod -a -G g1 u2

chown -R u1 /home/test13
chgrp -R g1 /home/test13

chmod 750 /home/test13
chmod 660 /home/test13/*
