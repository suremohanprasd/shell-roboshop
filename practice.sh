#!/bin/bash

# Installation of $PACKAGE1
#  First we need to check wether we are running with root access

USERID=$(id -u)
PACKAGE1=mysql
PACKAGE2=nginx
PACKAGE3=httpd
R="-e \e[31m"
G="-e \e[32m"
Y="-e \e[33m"
N="\e[0m"

VALIDATE() {
    if [ $1 -eq 0 ]
    then
        echo $G "Installation of $2 is Success..." $N
    else
        echo $R "Installation of $2 is Failed..." $N
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
    echo $R "$PACKAGE1 is not installed please wait installing it..." $N
    dnf install $PACKAGE1 -y
    VALIDATE $? "$PACKAGE1"
else
    echo $G "$PACKAGE1 is already installed" $N
fi

dnf list installed $PACKAGE2 -y

if [ $? -ne 0 ]
then
    echo $R "$PACKAGE2 is not installed please wait installing it..." $N
    dnf install $PACKAGE2 -y
    VALIDATE $? "$PACKAGE2"
else
    echo $G "$PACKAGE2 is already installed" $N
fi

dnf list installed $PACKAGE3 -y

if [ $? -ne 0 ]
then
    echo $R "$PACKAGE3 is not installed please wait installing it..." $N
    dnf install $PACKAGE3 -y
    VALIDATE $? "$PACKAGE3"
else
    echo $G "$PACKAGE3 is already installed" $N
fi