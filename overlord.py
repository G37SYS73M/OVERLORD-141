
from colorama import Fore, Back, Style
import re, subprocess, os
import modules

banner_Text = """
888888888888  88                                                                               
     88       88                                                                               
     88       88                                                                               
     88       88,dPPYba,    ,adPPYba,                                                          
     88       88P'    "8a  a8P_____88                                                          
     88       88       88  8PP"""""""                                                          
     88       88       88  "8b,   ,aa                                                          
     88       88       88   `"Ybbd8"'                                                          
                                                                                               
                                                                                               
                                                                                               
  ,ad8888ba,                                         88                                    88  
 d8"'    `"8b                                        88                                    88  
d8'        `8b                                       88                                    88  
88          88  8b       d8   ,adPPYba,  8b,dPPYba,  88   ,adPPYba,   8b,dPPYba,   ,adPPYb,88  
88          88  `8b     d8'  a8P_____88  88P'   "Y8  88  a8"     "8a  88P'   "Y8  a8"    `Y88  
Y8,        ,8P   `8b   d8'   8PP"""""""  88          88  8b       d8  88          8b       88  
 Y8a.    .a8P     `8b,d8'    "8b,   ,aa  88          88  "8a,   ,a8"  88          "8a,   ,d88  
  `"Y8888Y"'        "8"       `"Ybbd8"'  88          88   `"YbbdP"'   88           `"8bbdP"Y8  
                                                                                            
"""
version = "Version:1.0"
author = "Author: @G37SYS73M"
usages="""
Usages:
1: Auto Setup
2: Check Devices
3: Sniff Wifi Networks
4: Audit WPA Personal
9: Auto Stop
0: Exit
"""


def banner():
  print(Fore.RED + banner_Text)
  print(Fore.YELLOW + Style.BRIGHT + version +"  "+ author)
  print(Fore.GREEN + Style.BRIGHT + usages + Style.RESET_ALL)

def options():
  while True:
    cmd = input(Fore.RED + Style.BRIGHT + "OVERLORD# " + Style.RESET_ALL)
    if cmd != '0':
      if cmd == '1':
        modules.autoSetup()
      elif cmd == '2':
        modules.checkDevice()
      elif cmd == '3':
        modules.sniffNetwork()
      elif cmd == '4':
        modules.testWPA_PSK()
      elif cmd == '9':
        modules.autoStop()
      else:
        print(Fore.GREEN + Style.BRIGHT + usages + Style.RESET_ALL)
    else:
      exit()
      
if __name__ == "__main__":
  banner()
  options()