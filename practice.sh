#!/bin/bash

# Installation of $PACKAGE1
#  First we need to check wether we are running with root access

USERID=$(id -u)
PACKAGE1=mysql
PACKAGE2=nginx
PACKAGE3=httpd
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE() {
    if [ $1 -eq 0 ]
    then
        echo "Installation of $2 is Success..."
    else
        echo "Installation of $2 is Failed..."
    exit 1
    fi
}

if [ $USERID -ne 0 ]
then
    echo $R "Please run with root access" $N
else
    echo $G "You are running with root access" $N
fi

dnf list installed $PACKAGE1 -y

if [ $? -ne 0 ]
then
    echo "$PACKAGE1 is not installed please wait installing it..."
    dnf install $PACKAGE1 -y
    VALIDATE $? "$PACKAGE1"
else
    echo "$PACKAGE1 is already installed"
fi

dnf list installed $PACKAGE2 -y

if [ $? -ne 0 ]
then
    echo "$PACKAGE2 is not installed please wait installing it..."
    dnf install $PACKAGE2 -y
    VALIDATE $? "$PACKAGE2"
else
    echo "$PACKAGE2 is already installed"
fi

dnf list installed $PACKAGE3 -y

if [ $? -ne 0 ]
then
    echo "$PACKAGE3 is not installed please wait installing it..."
    dnf install $PACKAGE3 -y
    VALIDATE $? "$PACKAGE3"
else
    echo "$PACKAGE3 is already installed"
fi