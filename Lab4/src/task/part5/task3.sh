#!/bin/bash

systemctl enable mnt-mydata.mount

systemctl start mnt-mydata.mount

systemctl status mnt-mydata.mount

mount | grep /mnt/mydata
