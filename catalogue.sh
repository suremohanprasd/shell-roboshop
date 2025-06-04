#!/bin/bash

R="-e \e[31m"
G="-e \e[32m"
Y="-e \e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/roboshop-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)    # $0 -> have the script name
mkdir -p $LOGS_FOLDER
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
SCRIPT_DIR=$PWD

echo "Script started executing at : $(date)" &>>$LOG_FILE


USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo $R "ERROR:: Please run this script with root access" $N | tee -a $LOG_FILE
    exit 1 #give other than 0 upto 127
else
    echo $G "You are running with root access" $N | tee -a $LOG_FILE
fi

# validate functions takes input as exit status, what command they tried to install
VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo $G "$2 is ... SUCCESS" $N | tee -a $LOG_FILE
    else
        echo $R "$2 is ... FAILURE" $N | tee -a $LOG_FILE
        exit 1
    fi
}

dnf module disable nodejs -y
VALIDATE $? "Disabling default nodejs"

dnf module enable nodejs:20 -y
VALIDATE $? "Enabling nodejs:20"

dnf install nodejs -y
VALIDATE $? "Installing nodejs:20"

id roboshop
if [ $? -ne 0 ]
then
    useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
    VALIDATE $? "Adding System user Roboshop"
else
    echo $Y "System user Roboshop already Exits... Skipping" $Name
fi

mkdir -p /app
VALIDATE $? "Creating app directory"

rm -rf /app/*

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip 
cd /app 
unzip /tmp/catalogue.zip
VALIDATE $? "Downloading dependencies"

cd /app 
npm install
VALIDATE $? "Installing NPM"

cp $SCRIPT_DIR/catalogue.service /etc/systemd/system/catalogue.service

systemctl daemon-reload
systemctl enable catalogue 
systemctl start catalogue
VALIDATE $? "Starting catalogue service"

cp $SCRIPT_DIR/mongodb.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "Copying mongodb repo"

dnf install mongodb-mongosh -y
VALIDATE $? "Installing MongoDB clinet"
