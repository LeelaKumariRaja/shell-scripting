#!bin/bash

DISK_USAGE=$(df -hT | grep xfs)
DISK_THRESHOLD=15

while IFS= read -r line
do
    USAGE=$(echo $line | awk -F " " '{print $6f}' |cut -d "%" -f1)
    FOLDER=$(echo $line | awk -F " " '{print $Nf}')
    if [ $USAGE -ge $DISK_THRESHOLD ]
    then
        echo $FOLDER is more than $DISK_THRESHOLD. current usage is $USAGE
    fi
done <<< $DISK_USAGE
