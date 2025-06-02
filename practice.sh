#!/bin/bash

TIMESTAMP=$(date)
ENDTIME=$(date)
TOTALTIME=$($TIMESTAMP-$ENDTIME)

echo "Script run at the time of : $TIMESTAMP"

echo "Enter your pin"

read -s PIN

echo "your pin is : $PIN"

echo "Script End at : $ENDTIME"

echo "Total time to run the script : $TOTALTIME"
