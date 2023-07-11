#!/bin/bash

if [ "$#" -lt 1 ]
then
	echo "[*] Usages: ./deviceInfo.sh {Interface_name}"
	exit 1
fi

if [ "$#" -eq 1 ]
then
	echo "[*] Available Name:"
	iw dev | grep "Interface" | cut -d " " -f2
	echo "[*] Current Mode:"
	iwconfig $1 | grep "Mode" | cut -d ":" -f2 | awk '{print $1}'
	echo "[*] Current Channel:"
	iwlist $1 channel | grep "Current" | cut -d "" -f2 
fi