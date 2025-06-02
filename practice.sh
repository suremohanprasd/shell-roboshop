#!/bin/bash

echo "Enter first number"
read NUMBER1
echo "Enter second number"
read NUMBER2
echo "Enter third number"
read NUMBER3
echo "Enter fouth number"
read NUMBER4

# NUMBER=$("$NUMBER1" "$NUMBER2" "$NUMBER3" "$NUMBER4")

if [ $NUMBER1 lt 10]
then
    echo "${NUMBER[0]} is less than 10"
else
    echo "${NUMBER[0]} is greater than 10"
fi