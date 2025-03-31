#!/bin/bash

ionice -c 3 ./backup.sh
nice -n 19 ionice -c 2 -n 7 ./backup.sh
