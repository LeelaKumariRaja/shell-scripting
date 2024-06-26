#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPTNAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPTNAME-$TIMESTAMP.log

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

dnf install mysql -y &>> $LOGFILE

VALIDATE  "Intsalling MYSQL"

dnf install git -y &>> $LOGFILE

VALIDATE  "Intsalling GIT"