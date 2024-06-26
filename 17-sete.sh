#!/bin/bash

set -e

failure()
{
    echo "failed at line- $1 and command is- $2"
}

trap 'failure ${LINENO} "$BASH_COMMAND"' ERR

USERID=$(id -u)


if [ $USERID -ne 0 ]
then 
    echo "execute with super user access"
    exit 1
else
    echo "You are super user"
fi


dnf install myysql -y 
dnf install git -y

echo "is script proceeding"
