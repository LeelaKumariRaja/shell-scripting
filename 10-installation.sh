#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "execute with super user access"
    exit 1
else
    echo "You are super user"
fi

dnf install mysql -y