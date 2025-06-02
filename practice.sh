#!/bin/bash

# Installation of MySQL
#  First we need to check wether we are running with root access

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "Please run with root access"
else
    echo "You are running with root access"
fi

dnf list installed mysql -y

if [ $? -ne 0 ]
then
    echo "MySQL is not installed please wait installing it..."
    dnf install mysql -y
    if [ $? -eq 0 ]
    then
        echo "Installation of MySQL is Success..."
    else
        echo "Installation of MySQL is Failed..."
    exit 1
    fi
else
    echo "MySQL is already installed"
fi

dnf list installed nginx -y

if [ $? -ne 0 ]
then
    echo "nginx is not installed please wait installing it..."
    dnf install mysql -y
    if [ $? -eq 0 ]
    then
        echo "Installation of Nginx is Success..."
    else
        echo "Installation of Nginx is Failed..."
    exit 1
    fi
else
    echo "Nginx is already installed"
fi

dnf list installed httd -y

if [ $? -ne 0 ]
then
    echo "httd is not installed please wait installing it..."
    dnf install mysql -y
    if [ $? -eq 0 ]
    then
        echo "Installation of httd is Success..."
    else
        echo "Installation of httd is Failed..."
    exit 1
    fi
else
    echo "httd is already installed"
fi