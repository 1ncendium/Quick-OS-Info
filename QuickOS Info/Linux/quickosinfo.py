# Python script that outputs some important OS info about a Linux machine
# Date 11/1/2020
# Author : Incendium
# Version: 1.0

#Imports
import os
import socket
import urllib.request
from settings.colors import COLORS

def colorText(text):
    for color in COLORS:
        text = text.replace("[[" + color + "]]", COLORS[color])
    return text

#OS INFO
user = os.popen("whoami").read()
path = os.popen("echo $PATH").read()
hostname = socket.gethostname()
ip = urllib.request.urlopen('https://ident.me').read().decode('utf8')
osversion = os.popen("cat /etc/os-release").read()
OSinfoTitle = "\n[[red]]<< OS INFO >>[[white]]"

print(colorText(OSinfoTitle))
print("Hostname = ", hostname)
print("IP Address = ", ip)
print("Path = ", path)
print("User = ", user)
print("Server version & distribution : \n",osversion)

#ETC/PASSWD
etcPASSWDTitle = "\n[[red]]<< ETC/PASSWD File >>[[white]]"
print(colorText(etcPASSWDTitle))
os.system("cat /etc/passwd")

#CRON JOBS
CronJobTitle = "\n[[red]]<< Cron Jobs for user >>[[white]]"
print(colorText(CronJobTitle),user)
os.system("cat /etc/crontab")

#DISPLAY SERVICES
DisplayServicesTitle = "\n[[red]]<< Services running on host >>[[white]]"
print(colorText(DisplayServicesTitle))
os.system("service --status-all")

#DISPLAY SUID / GUID FILES
DisplaySGUIDFilesTitle = "\n[[red]]<< SUID / GUID Files found >>[[white]]"
print(colorText(DisplaySGUIDFilesTitle))
os.system("find / -perm -u=s type f 2>/dev/null")
os.system("find . -perm /6000")

#DISPLAY POSSIBLE SSH_KEYS IN SSH FOLDER
DisplaySSHKeys = "\n[[red]]<< Possible SSH Keys in SSH folder >>[[white]]"
print(colorText(DisplaySSHKeys))
os.system("ls -al ~/.ssh")

#DISPLAY INTERESTING FILES
DisplayInterFiles = "\n[[red]]<< Interesting Files you may take a look at >>[[white]]"
print(colorText(DisplayInterFiles))

with open("../Wordlist/findfiles.txt") as filefinder:
 for line in filefinder:
    try:
        os.system("find /home 2>/dev/null | grep "+line)
    except:
        print("")

#end of script
end = "\n[[green]]<< Done >> [[white]]"
print(colorText(end))

