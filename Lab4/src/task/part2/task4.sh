#!/bin/bash

systemctl status cronie.service

#Если сервис не запущен, его можно запустить:

systemctl start cronie.service
