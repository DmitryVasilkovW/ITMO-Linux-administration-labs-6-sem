#!/bin/bash

password=$(openssl passwd "87654321")

useradd -m -p "$password" u2
