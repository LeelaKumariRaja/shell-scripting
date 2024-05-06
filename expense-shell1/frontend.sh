#!bin/bash
echo "Please enter DB password"
read -s mysql_root_pwd


dnf install nginx -y &>> $LOGFILE
VALIDATE "installing nginx"


systemctl enable nginx &>> $LOGFILE
VALIDATE "enabling nginx"

systemctl start nginx &>> $LOGFILE
VALIDATE "starting nginx"

rm -rf /usr/share/nginx/html/* &>> $LOGFILE
VALIDATE "removing existing html content"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>> $LOGFILE
VALIDATE "getting frontentd code"

cd /usr/share/nginx/html 
unzip /tmp/frontend.zip &>> $LOGFILE
VALIDATE "going to path"

cp /home/ec2-user/shell-scripting/expense-shell/expense.conf /etc/nginx/default.d/expense.conf &>> $LOGFILE
VALIDATE "copying config folder"

systemctl restart nginx &>> $LOGFILE
VALIDATE "restarting nginx"


