#!/bin/bash

NUMBER=$("$1" "$2" "$3" "$4")

if [ ${NUMBER[0]} lt 10]
then
    echo "${NUMBER[0]} is less than 10"
else
    echo "${NUMBER[0]} is greater than 10"
fi 