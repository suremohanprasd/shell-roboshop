#!/bin/bash

# Installation of MySQL
#  First we need to check wether we are running with root access

USERID=$(id -u)

if [ $USERID eq 0 ]
then
    echo "You are running with root access"
else
    echo "Please run with root access"
fi

dnf list installed mysql -y

if [ $? ne 0]
then
    echo "MySQL is not installed please wait installing it..."
    dnf install mysql -y
else
    echo "MySQL is already installed"
fi

