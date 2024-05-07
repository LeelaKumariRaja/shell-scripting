#!bin/bash

R="\e[31m"
G="\e[32m"
N="\e[0m"

SOURCE_DIRECTORY=tmp/app-logs

if [ -d $SOURCE_DIRECTORY ]
then
    echo "source directory exists"
else
    echo "$R  please make sure $SOURCE_DIRECTORY exists $N"
    exit 1
fi
