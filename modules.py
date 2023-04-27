import time,os,re, csv
from colorama import Fore, Back, Style

#has to be debugged to check the airodump-ng
def checkDevice():
    os.system("iwconfig wlan0 > .tmp/checkDevices.log")
    os.system("which airodump-ng > .tmp/airmon.log")
    time.sleep(1)
    try:
        with open(".tmp/checkDevices.log") as f:
            with open(".tmp/airmon.log") as f2:
                line = f.read()
                line2 = f2.read()
                if re.search("wlan0",line):
                    print(Fore.GREEN + Style.BRIGHT + "wlan0" + "> Found!!!" + Style.RESET_ALL)
                if "/usr/sbin/airodump-ng" in line2:
                    print(Fore.GREEN + Style.BRIGHT + "airmon-ng" + "> Found!!!" + Style.RESET_ALL)                            
    except:
        print("ERROR checkDevice")

def autoSetup():
    os.system("airmon-ng start wlan0 > .tmp/moniter.log")
    time.sleep(1)
    try:
        with open(".tmp/moniter.log") as f:
            line = f.read()
            if re.search("monitor",line):
                print(Fore.GREEN + Style.BRIGHT + "> wlan0 set to monitor mode" + Style.RESET_ALL)
                return 0
    except:
        print("ERROR autoSetup")
        
                              
def autoStop():
    os.system("airmon-ng stop wlan0 > .tmp/managed.log") 
    time.sleep(1)
    try:
        with open(".tmp/managed.log") as f:
            line = f.read()
            if re.search("managed",line):
                print(Fore.GREEN + Style.BRIGHT + "> wlan0 set to managed mode" + Style.RESET_ALL)
                return 0
    except:
        print("ERROR autoStop")



def sniffNetwork():
    
    cmd = f"airodump-ng wlan0"
    os.system(cmd)
        
def testWPA_PSK():
    bssid = input("Set BSSID: ")
    channel= input("Set Channel: ")
    cmd = f"iw wlan0 set channel {channel}"
    os.system(cmd)
    date_time = time.asctime()
    cmd2 = f"airodump-ng  --bssid {bssid} --channel {channel} wlan0 -w 'logs/{date_time}'"
    os.system(cmd2)
    
    

        

    
        
  

        