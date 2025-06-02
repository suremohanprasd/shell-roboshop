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

LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)    # $0 -> have the script name
mkdir -p $LOGS_FOLDER
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

echo "Script started executing at : $(date)" &>>$LOG_FILE

VALIDATE() {
    if [ $1 -eq 0 ]
    then
        echo $G "Installation of $2 is Success..." $N | tee -a $LOG_FILE
    else
        echo $R "Installation of $2 is Failed..." $N | tee -a $LOG_FILE
    exit 1
    fi
}

if [ $USERID -ne 0 ]
then
    echo $R "Please run with root access" $N | tee -a $LOG_FILE
else
    echo $G "You are running with root access" $N | tee -a $LOG_FILE
fi

dnf list installed $PACKAGE1 -y

if [ $? -ne 0 ]
then
    echo $R "$PACKAGE1 is not installed please wait installing it..." $N | tee -a $LOG_FILE
    dnf install $PACKAGE1 -y &>>$LOG_FILE
    VALIDATE $? "$PACKAGE1"
else
    echo $G "$PACKAGE1 is already installed" $N | tee -a $LOG_FILE
fi

dnf list installed $PACKAGE2 -y

if [ $? -ne 0 ]
then
    echo $R "$PACKAGE2 is not installed please wait installing it..." $N | tee -a $LOG_FILE
    dnf install $PACKAGE2 -y &>>$LOG_FILE
    VALIDATE $? "$PACKAGE2"
else
    echo $G "$PACKAGE2 is already installed" $N | tee -a $LOG_FILE
fi

dnf list installed $PACKAGE3 -y

if [ $? -ne 0 ]
then
    echo $R "$PACKAGE3 is not installed please wait installing it..." $N | tee -a $LOG_FILE
    dnf install $PACKAGE3 -y &>>$LOG_FILE
    VALIDATE $? "$PACKAGE3"
else
    echo $G "$PACKAGE3 is already installed" $N | tee -a $LOG_FILE
fi