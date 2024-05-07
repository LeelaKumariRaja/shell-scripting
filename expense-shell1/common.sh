#!bin/bash

set -e

ValidateCommand()
{
    echo "error occured at line no- $1 and command is -$2"
}

trap 'ValidateCommand ${LINENO} "$BASH_COMMAND"' ERR

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
FILENAME=$(echo $0 | cut -d "/" -f2)
LOGFILE=/tmp/$FILENAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
N="\e[0m"

VALIDATE()
{
    if [ $? -ne 0 ]
    then
        echo "$1 failed.exiting"
        exit 12
    else
        echo "$1 successful"
    fi
}

CHECKROOTUSER()
{
if [ $USERID -ne 0 ]
    then
        echo "Run script with super user access:"
        exit 1
else
    echo "You are super user"
fi
}