#!/bin/bash

# Installation of MySQL
#  First we need to check wether we are running with root access

USERID=$(id -u)

if [ $USERID eq 0]
than
    echo "You are running with root access"
else
    echo "Please run with root access"
fi