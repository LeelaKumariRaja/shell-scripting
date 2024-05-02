#!/bin/bash

USERID=$(id -u)

VALIDATE()
{
if [ $? -ne 0 ]
then
    echo "above installation failed"
    exit 1
else
    echo "above command is success. Going ahead with $1"
fi
}

if [ $USERID -ne 0 ]
then 
    echo "execute with super user access"
    exit 1
else
    echo "You are super user"
fi

dnf install mysqll -y

VALIDATE  "Intsalling MYSQL"

dnf install git -y

VALIDATE  "Intsalling GIT"