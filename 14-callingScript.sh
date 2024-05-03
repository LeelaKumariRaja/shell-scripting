#!/bin/bash

COURSE="from current script"

echo "$COURSE"
echo "PID is: $$"

# 1st way
# ./15-otherScript.sh

source ./16-otherScript.sh

echo "$COURSE"
echo "PID is: $$"