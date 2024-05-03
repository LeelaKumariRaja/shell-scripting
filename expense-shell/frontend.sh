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


dnf install nginx -y &>> $LOGFILE
VALIDATE "installing nginx"


systemctl enable nginx &>> $LOGFILE
VALIDATE "enabling nginx"

systemctl start nginx &>> $LOGFILE
VALIDATE "starting nginx"

rm -rf /usr/share/nginx/html/*
VALIDATE "removing existing html content"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip
VALIDATE "getting frontentd code"

cd /usr/share/nginx/html
unzip /tmp/frontend.zip
VALIDATE "going to path"




