#!/bin/bash

if [ "$#" -lt 4 ]
then
	echo "[*] Usages: ./scanNetwork.sh {Interface_name} {BSSID} {Channel_Number} {time_to_listen}"
	exit 1
fi

if [ "$#" -eq 4 ]
then
	foldername=`date +%d-%m-%y`
	filename=`date +%H_%M-$2`
	mkdir -p /tmp/$foldername
	iw $1 set channel $3 > /dev/null 
	xterm -e timeout $4m airodump-ng $1 --bssid $2 --channel $3 -w /tmp/$foldername/$filename_$2
	cat /tmp/$foldername/$filename_$2-01.csv
fi

