USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
FILENAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$LOGFILE-$FILENAME.log

VALIDATE()
{
    if [ $? -ne 0 ]
    then
        echo "installing $1 failed.exiting"
        exit 12
    else
        echo "installation successful for $1"
}

if [ $USERID -ne 0 ]
    then
        echo "Run script with super user access:"
        exit 1
else
    echo "You are super user"
fi

dnf install mysql-server -y &>> $LOGFILE
VALIDATE "mysql-server"
