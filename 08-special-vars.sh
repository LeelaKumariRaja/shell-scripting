#!/bin/bash

echo "All varibales: $@"
echo  "Number of variables passed: $#"
echo "script name:$0"
echo "curremt working directory : $PWD"
echo "curremt home directory : $HOME"
echo "curremt user : $USER"
echo "hostname; $HOSTNAME"
echo "process id of current command: $$"
sleep 15
echo "process id of last command : $!"
