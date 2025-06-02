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

PACKAGES=("$PACKAGE1" "$PACKAGE2" "$PACKAGE3")
 
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

for package in ${PACKAGES[@]}
do
   dnf list installed $package &>>$LOG_FILE
   if [ $? -ne 0 ]
   then
       echo $R "$package is not installed... going to install it" $N | tee -a $LOG_FILE
       dnf install $package -y &>>$LOG_FILE
       VALIDATE $? "$package"
    else
       echo $G "$package is already installed...Nothing to do" $N | tee -a $LOG_FILE
    fi
done
