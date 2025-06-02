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

dnf module disable nodejs -y  &>>$LOG_FILE
VALIDATE $? "Disabling default Nodejs"

dnf module enable nodejs:20 -y  &>>$LOG_FILE
VALIDATE $? "Enabling Nodejs:20"

dnf install nodejs -y   &>>$LOG_FILE
VALIDATE $? "Installing Nodejs:20"

id roboshop
if [ $? -ne 0 ]
then
    useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
    VALIDATE $? "Creating system user"
else
    echo "Already roboshop user  is exits, So $Y SKIPPING.... $N"
if

rm -rf /app/* &>>$LOG_FILE
mkdir -p /app 
VALIDATE $? "Creating app directory"

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip &>>$LOG_FILE
cd /app 
unzip /tmp/catalogue.zip  &>>$LOG_FILE
VALIDATE $? "Download the dependencies"

cd /app 
npm install  &>>$LOG_FILE
VALIDATE $? "Installing npm"

cp $SCRIPT_DIR/catalogue.service /etc/systemd/system/catalogue.service
VALIDATE $? "Copying catalogue service file"

systemctl daemon-reload  &>>$LOG_FILE
VALIDATE $? "daemon realoading"

systemctl enable catalogue  &>>$LOG_FILE
VALIDATE $? "Enabling catalogue"

systemctl start catalogue  &>>$LOG_FILE
VALIDATE $? "Staring catalogue"

cp $SCRIPT_DIR/mongodb.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE
VALIDATE $? "Installing MongoDB client file"

dnf install mongodb-mongosh -y  &>>$LOG_FILE
VALIDATE $? "Installing MongoDB clinet"

STATUS=$(mongosh --host mongodb.daws84s.site --eval 'db.getMongo().getDBNames().indexOf("catalogue")')
if [ $STATUS -lt 0 ]
then
    mongosh --host mongodb.daws84s.site </app/db/master-data.js &>>$LOG_FILE
    VALIDATE $? "Loading data into MongoDB"
else
    echo "Data is already loaded ... $Y SKIPPING $N"
fi