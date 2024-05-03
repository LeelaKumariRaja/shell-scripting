USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
FILENAME=$(echo $0 | cut -d "/" -f2)
LOGFILE=/tmp/$FILENAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
N="\e[0m"
echo "Please enter DB password"
read -s mysql_root_pwd


VALIDATE()
{
    if [ $? -ne 0 ]
    then
        echo -e "$1  $R  failed. $N exiting"
        exit 12
    else
        echo -e "$1 $G  successful $N"
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

 if [ $? -ne 0 ]
 then 
    useradd expense &>> $LOGFILE
    VALIDATE "adding  user"
else
    echo "user already added.skipping"
fi

mkdir -p /app  &>> $LOGFILE
VALIDATE "creating app folder"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip  &>> $LOGFILE
VALIDATE "downloading code"

cd /app
#remove existing code then unzip
rm -rf /app/*
unzip /tmp/backend.zip  &>> $LOGFILE
VALIDATE "unzipping code"

npm install  &>> $LOGFILE
VALIDATE "installing nodejs dependencies"

cp /home/ec2-user/shell-scripting/expense-shell/backend.service /etc/systemd/system/backend.service  &>> $LOGFILE
VALIDATE "copied backend service"


systemctl daemon-reload  &>> $LOGFILE
VALIDATE "daemon reload"

systemctl start backend  &>> $LOGFILE
VALIDATE "start backend"

systemctl enable backend  &>> $LOGFILE
VALIDATE "enable backend"

dnf install mysql -y &>> $LOGFILE
VALIDATE "Installing sql client"

mysql -h db.traindevops.online -uroot -p${mysql_root_pwd} < /app/schema/backend.sql  &>> $LOGFILE
VALIDATE "schema loading"

systemctl restart backend  &>> $LOGFILE
VALIDATE "restart backend"