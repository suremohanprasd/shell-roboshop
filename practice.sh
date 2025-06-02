#!/bin/bash

# Installation of $PACKAGE1
#  First we need to check wether we are running with root access

USERID=$(id -u)
PACKAGE1=mysql
PACKAGE2=nginx
PACKAGE3=httpd

if [ $USERID -ne 0 ]
then
    echo "Please run with root access"
else
    echo "You are running with root access"
fi

dnf list installed $PACKAGE1 -y

if [ $? -ne 0 ]
then
    echo "$PACKAGE1 is not installed please wait installing it..."
    dnf install $PACKAGE1 -y
    if [ $? -eq 0 ]
    then
        echo "Installation of $PACKAGE1 is Success..."
    else
        echo "Installation of $PACKAGE1 is Failed..."
    exit 1
    fi
else
    echo "$PACKAGE1 is already installed"
fi

dnf list installed $PACKAGE2 -y

if [ $? -ne 0 ]
then
    echo "$PACKAGE2 is not installed please wait installing it..."
    dnf install $PACKAGE2 -y
    if [ $? -eq 0 ]
    then
        echo "Installation of $PACKAGE2 is Success..."
    else
        echo "Installation of $PACKAGE2 is Failed..."
    exit 1
    fi
else
    echo "$PACKAGE2 is already installed"
fi

dnf list installed $PACKAGE3 -y

if [ $? -ne 0 ]
then
    echo "$PACKAGE3 is not installed please wait installing it..."
    dnf install $PACKAGE3 -y
    if [ $? -eq 0 ]
    then
        echo "Installation of $PACKAGE3 is Success..."
    else
        echo "Installation of $PACKAGE3 is Failed..."
    exit 1
    fi
else
    echo "$PACKAGE3 is already installed"
fi