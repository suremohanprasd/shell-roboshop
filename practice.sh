#!/bin/bash

echo "Enter any number"

read NUMBER

if [ $NUMBER lt 10 ]
then
    echo "$NUMBER is less than 10"
else
    echo "$NUMBER is greater than 10"
fi