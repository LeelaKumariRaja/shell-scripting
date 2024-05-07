#!/bin/bash


echo "Please enter DB password"
read -s mysql_root_pwd

source ./common.sh

CHECKROOTUSER 

dnf install mysql-servaaer -y &>> $LOGFILE

systemctl enable mysqld  &>>$LOGFILE


systemctl start  mysqld  &>>$LOGFILE

#mysql_secure_installation --set-root-pass ExpenseApp@1  &>>$LOGFILE
#VALIDATE "setting password"

#  mysql -h db.traindevops.online -uroot -pExpenseApp@1 -e 'SHOW DATABASES;' &>> $LOGFILE

#  if [ $? -ne 0 ]
#  then 
#     mysql_secure_installation --set-root-pass ExpenseApp@1  &>>$LOGFILE
#     VALIDATE "setting root password"
# else
#     echo "mysql root password already set.skipping"
# fi


 mysql -h db.traindevops.online -uroot -p${mysql_root_pwd} -e 'SHOW DATABASES;' &>> $LOGFILE

 if [ $? -ne 0 ]
 then 
    mysql_secure_installation --set-root-pass ${mysql_root_pwd}  &>>$LOGFILE
else
    echo "mysql root password already set.skipping"
fi