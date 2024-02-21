#!/bin/bash

if [ "$#" -lt 1 ]
then
	echo "[*] Usages: ./WIFY.sh {Interface_name}"
	./scripts/deviceInfo.sh
	exit 1
fi

if [ "$#" -eq 1 ]; then

echo "!!!!!!!!!!!WELCOME!!!!!!!!!!!"

interface_name=$1
echo "

[*] Using Device => $interface_name

"

project_name=''
read -p "Enter the Project's Name: " project_name
mkdir projects/$project_name

OPTIONS='
OPTIONS:\n
1 => Put Device in Monitor Mode \n
2 => Put Device in Managed Mode \n
3 => Scan For Access Points (APs) \n
4 => Scan An Access Point (AP) \n
5 => Auto WPA Attacks Using Wifite \n
6 => Auto WEP Attacks Using Wifite
'

echo -e $OPTIONS


keyword="exit"
user_input=""

read -p "Enter an option (type 'exit' to stop): " user_input

while [ "$user_input" != "$keyword" ]
do
    
	#Putting in moniter mode.
    if [ $user_input -eq 1 ]; then  
    	echo `date +%d-%m-%y-%H_%M` >> projects/$project_name/command.logs
    	./scripts/deviceManagment.sh $interface_name 1 | tee projects/$project_name/command.logs

    #putting in managed mode
    elif [ $user_input -eq 2 ]; then
    	echo `date +%d-%m-%y-%H_%M` >> projects/$project_name/command.logs
    	./scripts/deviceManagment.sh $interface_name 2 | tee projects/$project_name/command.logs

    #Scanning for all networks
    elif [ $user_input -eq 3 ]; then
    	mins=5
    	user_input_mins=''
    	read -p "Enter time to sniff (Miniutes)(Default: 5mins): " user_input_mins
    	if [ -n "$user_input_mins" ]; then
    		mins=$user_input_mins
		fi
    	cmd_time=`date +%d-%m-%y-%H_%M`
    	echo $cmd_time >> tee projects/$project_name/command.logs 
    	./scripts/scanForNetworks.sh $interface_name $mins | tee projects/$project_name/command.logs | tee projects/$project_name/scanForNetworks.txt

    #Scanning an AP
    elif [ $user_input -eq 4 ]; then
		mins=''
    	bssid=''
    	channel=''
    	mins=5
    	user_input_mins=''
    	read -p "Enter BSSID: " bssid
    	read -p "Enter Channel Number: " channel
    	read -p "Enter time to scan AP (Miniutes)(Default: 5mins): " user_input_mins
    	if [ -n "$user_input_mins" ]; then
    		mins=$user_input_mins
		fi
    	cmd_time=`date +%d-%m-%y-%H_%M`
    	echo $cmd_time >> tee -a projects/$project_name/command.logs
		./scripts/scanNetwork.sh $interface_name $bssid $channel $mins | tee projects/$project_name/command.logs | tee projects/$project_name/scan-$bssid.txt
		cat projects/$project_name/scan-$bssid.txt | awk 'NR==2 {ssid=$0; getline} END {printf "\"%s\",\"%s\"\n", ssid, $0}' >> projects/$project_name/ScannedAPs.csv

	#Auto WPA attacks Using Wifite
    elif [ $user_input -eq 5 ]; then
    	echo "[*] ScannedAPs:"
    	cat projects/$project_name/ScannedAPs.csv
    	essid=''
    	read -p "Enter target AP's EISSID: " essid
    	cmd_time=`date +%d-%m-%y-%H_%M`
    	echo $cmd_time >> projects/$project_name/command.logs
    	./scripts/wpaAttacks.sh $interface_name $essid | tee projects/$project_name/command.logs | tee projects/$project_name/Attack-WPA-Wifite-$essid.txt


	#Auto WEP attacks Using Wifite
    elif [ $user_input -eq 5 ]; then
    	echo "[*] ScannedAPs:"
    	cat projects/$project_name/ScannedAPs.csv
    	essid=''
    	read -p "Enter target AP's EISSID: " essid
    	cmd_time=`date +%d-%m-%y-%H_%M`
    	echo $cmd_time >> projects/$project_name/command.logs
    	./scripts/wepAttacks.sh $interface_name $essid | tee projects/$project_name/command.logs | tee projects/$project_name/Attack-WEP-Wifite-$essid.txt




    else
    	echo -e "Invalid Options!!!"    
    fi

    echo -e $OPTIONS
    read -p "Enter an options (type 'exit' to stop): " user_input

done










fi #EOF DO NOT EDIT