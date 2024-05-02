#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "execute with super user access"
    exit 1
else
    echo "You are super user"
fi

dnf install mysqll -y

if [ $? -ne 0 ]
then
    echo "above installation failed"
    exit 1
else
    echo "above command is success. Going ahead with git installation"
fi

dnf install git -y
