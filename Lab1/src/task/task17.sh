#!/bin/bash

mkdir -p /home/test15

echo "239!" > /home/test15/secret_file

chmod 711 /home/test15
chmod 644 /home/test15/secret_file

