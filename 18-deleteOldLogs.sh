#!bin/bash

R="\e[31m"
G="\e[32m"
N="\e[0m"

SOURCE_DIRECTORY=/tmp/app-logs

if [ -d $SOURCE_DIRECTORY ]
then
    echo -e "source directory $G exists $N"
else
    echo -e "$R  please make sure $SOURCE_DIRECTORY exists $N"
    exit 1
fi

FILES=$(find $SOURCE_DIRECTORY -name "*.log" -mtime +14)

echo "Files to delete: $FILES"

while IFS= read -r line
do
echo "Deletig file : $line"
done <<< $FILES
