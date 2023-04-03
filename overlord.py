
from colorama import Fore, Back, Style
import re, subprocess, os

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
1: Auto Setup (Only works with rtl8812au)
2: Audit Wifi personal
0: Exit
"""


def banner():
  print(Fore.RED + banner_Text)
  print(Fore.YELLOW + Style.BRIGHT + version +"  "+ author)
  print(Fore.GREEN + Style.BRIGHT + usages + Style.RESET_ALL)

def autoSetup():
  print(Fore.GREEN)
  os.system("bashScripts/managed.sh")

def autoStop():
  print(Fore.GREEN)
  os.system("bashScripts/moniter.sh") 
  
  
def wifiPersonal():
  print("Personal WIFI")

def options():
  while True:
    cmd = input(Fore.RED + "OVERLORD# " + Style.RESET_ALL)
    if cmd != '0':
      if cmd == '1':
        autoSetup()
      elif cmd == '2':
        wifiPersonal()
      elif cmd == '9':
        autoStop()
      else:
        print(Fore.GREEN + Style.BRIGHT + usages + Style.RESET_ALL)
    else:
      exit()