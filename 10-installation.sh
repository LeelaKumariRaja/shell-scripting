#!/bin/bash

user=$(id -u)

if [user ne 0]
then 
    echo "execute with super user access"
else
    echo "You are super user"

dnf install mysql -y