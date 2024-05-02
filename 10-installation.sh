#!/bin/bash

USERID=$(id -u)

VALIDATE()
{
if [ $? -ne 0 ]
then
    echo " $1  failed"
    exit 1
else
    echo "$1 is success. Going ahead"
fi
}

if [ $USERID -ne 0 ]
then 
    echo "execute with super user access"
    exit 1
else
    echo "You are super user"
fi

dnf install mysql -y

VALIDATE  "Intsalling MYSQL"

dnf install git -y

VALIDATE  "Intsalling GIT"