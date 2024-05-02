#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPTNAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPTNAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
N="\e[0m"

VALIDATE()
{
if [ $? -ne 0 ]
then
    echo -e " $1  $R failed $N"
    exit 1
else
    echo -e "$1 is $G success. $N Going ahead"
fi
}

if [ $USERID -ne 0 ]
then 
    echo "execute with super user access"
    exit 1
else
    echo "You are super user"
fi

for i in $@
    do
        echo "package to install: $i"
        dnf list installed $i &>> $LOGFILE
        if [ $? -eq 0 ]
            then
                echo "already $i installed.skipping"
        else
            echo "$i not installed"
        fi
    done