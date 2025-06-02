#!/bin/bash

# Installation of MySQL
#  First we need to check wether we are running with root access

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "Please run with root access"
    exit 1
else
    echo "You are running with root access"
fi

dnf list installed mysql -y

if [ $? -ne 0 ]
then
    echo "MySQL is not installed please wait installing it..."
    dnf install mysql -y
    exit 1
else
    echo "MySQL is already installed"
fi