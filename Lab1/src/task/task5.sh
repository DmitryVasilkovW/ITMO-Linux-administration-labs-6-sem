#!/bin/bash

password=$(openssl passwd "12345678")

useradd -m -p "$password" u1
