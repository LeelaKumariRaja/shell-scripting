#!/bin/bash

COURSE="from current script"

echo "$COURSE"
echo "PID is: $$"

source ./15-otherScript.sh

echo "$COURSE"
echo "PID is: $$"