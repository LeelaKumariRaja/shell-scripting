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
    echo -e " $1  $R failed -e $N"
    exit 1
else
    echo -e "$1 is $G success. Going ahead -e $N"
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