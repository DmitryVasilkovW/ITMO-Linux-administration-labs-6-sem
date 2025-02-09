#!/bin/bash

ls -l ~/test/links/list_hlink | awk '{print ("hlink " $2)}'
ls -l ~/test/links/list_slink | awk '{print ("slink "$2)}'
ls -l ~/test/list | awk '{print ("list "$2)}'
