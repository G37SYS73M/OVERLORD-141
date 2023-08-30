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

OPTIONS='
OPTIONS:\n
1 => Put Device in Monitor Mode \n
2 => Put Device in Managed Mode \n
3 => Scan For Networks \n
4 => Scan A NetWork \n
'

echo -e $OPTIONS


keyword="exit"
user_input=""

read -p "Enter a keyword (type 'exit' to stop): " user_input

while [ "$user_input" != "$keyword" ]
do
    

    if [ $user_input -eq 1 ]; then  
    	./scripts/deviceManagment.sh $interface_name 1


    elif [ $user_input -eq 2 ]; then
    	./scripts/deviceManagment.sh $interface_name 2


    elif [ $user_input -eq 3 ]; then
    	mins=''
    	read -p "Enter time to sniff (Miniutes)(Default: 5mins): " mins
    	if [ $mins -eq 0 ];then
			./scripts/scanForNetworks.sh $interface_name 5
		else
			./scripts/scanForNetworks.sh $interface_name $mins
		fi


    elif [ $user_input -eq 4 ]; then
    	project_mode='N'
		read -p "Do you want to start in Project Mode (Y/N): " project_mode
		if [ $project_mode == 'Y' ]; then
    		echo 'In Development'
		else
    		mins=''
    		bssid=''
    		channel=''
    		read -p "Enter BSSID: " bssid
    		read -p "Enter Channel Number: " channel
    		read -p "Enter time to sniff (Miniutes)(Default: 5mins): " mins
    		if [ $mins -eq 0 ];then
				./scripts/scanNetwork.sh $interface_name $bssid $channel 5
			else
				./scripts/scanNetwork.sh $interface_name $bssid $channel $mins
			fi
		fi


    else
    	echo -e "Invalid Options!!!"    
    fi

    echo -e $OPTIONS
    read -p "Enter a keyword (type 'exit' to stop): " user_input

done










fi #EOF DO NOT EDIT