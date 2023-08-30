#!/bin/bash

	echo "[*] Available Name:"
	iw dev | grep "Interface" | cut -d " " -f2
	interface_name=`iw dev | grep "Interface" | cut -d " " -f2` 
	echo "[*] Current Mode:"
	iwconfig $interface_name | grep "Mode" | cut -d ":" -f2 | awk '{print $1}'
	echo "[*] Current Channel:"
	iwlist $interface_name channel | grep "Current" | cut -d "" -f2 
