#!/bin/sh
myFile="Makefile"

# to see if Makefile is exist
if [ ! -f "$myFile" ]; then
echo 'Do not have a Makefile, make a new one'
touch "$myFile"
echo 'done.'
else
echo 'Makefile exist'
fi
