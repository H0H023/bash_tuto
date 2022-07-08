#! /bin/bash

# Check either run with sudo or not 
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 13
fi


# Ask to proceed

read -p "Proceed ? (y/n) : " status

echo "$status"

if [[ "$status" == "y" ]]; then
	echo "Proceed with $status"
	exit 0
else
	echo "Its okay, Babye"
	exit 1
fi
