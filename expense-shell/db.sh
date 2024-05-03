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

dnf install mysql-server -y &>> $LOGFILE
VALIDATE "installing mysql-server"

systemctl enable mysqld  &>>$LOGFILE
VALIDATE "enabling mysql-server"


systemctl start  mysqld  &>>$LOGFILE
VALIDATE "starting  mysql-server"

mysql_secure_installation --set-root-pass ExpenseApp@1  &>>$LOGFILE
VALIDATE "setting password"