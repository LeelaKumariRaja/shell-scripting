USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
FILENAME=$(echo $0 | cut -d "/" -f2)
LOGFILE=/tmp/$FILENAME-$TIMESTAMP.log

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

if [ $USERID -ne 0 ]
    then
        echo "Run script with super user access:"
        exit 1
else
    echo "You are super user"
fi

dnf module disable nodejs -y &>> $LOGFILE
VALIDATE "disabling nodejs"

dnf module enable nodejs:20 -y &>> $LOGFILE
VALIDATE "enabling 20 nodejs"

dnf install nodejs -y &>> $LOGFILE
VALIDATE "insytalling 20 nodejs"

useradd expense -y &>> $LOGFILE
VALIDATE "adding expense user"