#!/bin/bash

if id "myuser" &>/dev/null; then
    usermod -a -G g1 myuser
else
    useradd -m myuser
    usermod -a -G g1 myuser
fi
