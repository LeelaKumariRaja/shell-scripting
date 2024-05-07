#!bin/bash


echo "Please enter DB password"
read -s mysql_root_pwd

source ./common.sh

dnf module disable nodejs -y &>> $LOGFILE

dnf module enable nodejs:20 -y &>> $LOGFILE

dnf install nodejs -y &>> $LOGFILE


id expense &>> $LOGFILE

 if [ $? -ne 0 ]
 then 
    useradd expense &>> $LOGFILE
else
    echo "user already added.skipping"
fi




mkdir -p /app  &>> $LOGFILE

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip  &>> $LOGFILE

cd /app
#remove existing code then unzip
rm -rf /app/*
unzip /tmp/backend.zip  &>> $LOGFILE

npm install  &>> $LOGFILE



cp /home/ec2-user/shell-scripting/expense-shell/backend.service /etc/systemd/system/backend.service  &>> $LOGFILE\

echo "is script proceeding"

systemctl daemon-reload  &>> $LOGFILE

systemctl start backend  &>> $LOGFILE

systemctl enable backend  &>> $LOGFILE

dnf install mysql -y &>> $LOGFILE

mysql -h db.traindevops.online -uroot -p${mysql_root_pwd} < /app/schema/backend.sql  &>> $LOGFILE

systemctl restart backend  &>> $LOGFILE