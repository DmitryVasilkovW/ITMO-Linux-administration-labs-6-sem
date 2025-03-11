#!/bin/bash

systemctl status cron.service

#Если сервис не запущен, его можно запустить:

systemctl start cron.service
