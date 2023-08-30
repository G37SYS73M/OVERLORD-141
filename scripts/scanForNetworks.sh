#!/bin/bash

if [ "$#" -lt 2 ]
then
	echo "[*] Usages: ./scanForNetworks.sh {Interface_name} {time_to_listen}"
	exit 1
fi

if [ "$#" -eq 2 ]
then
	foldername=`date +%d-%m-%y`
	filename=`date +%H_%M`
	mkdir -p /tmp/$foldername
	xterm -e timeout $2m airodump-ng $1 -w /tmp/$foldername/$filename
	echo "[*] SCAN RESULTS:"
	echo 'BSSID                     PWR     CH     Privacy         Cipher              ESSID'
	      
	cat /tmp/$foldername/$filename-01.csv | awk -F',' '{print $1 "\t" $9 "\t" $4 "\t" $6 "\t\t" $7 "\t\t" $14}' | tail --lines=+3 | grep -B 99999 "Station MAC" | grep -v "Station MAC"
fi



