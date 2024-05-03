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
        echo "$1 $R failed. $N exiting"
        exit 12
    else
        echo "$1 $G successful $N"
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

id expense &>> $LOGFILE
VALIDATE "checking expense user"

 if [ $? -ne 0 ]
 then 
    useradd expense&>>$LOGFILE
    VALIDATE "adding  user"
else
    echo "user already added.skipping"
fi