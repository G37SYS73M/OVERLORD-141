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
	cat /tmp/$foldername/$filename-01.csv
fi



