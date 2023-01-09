#!/bin/bash 

# Author: th3hostname (ak) IRVING ST 

#................................

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"
#.................................
trap  ctrl_c INT 


function ctrl_c(){
	echo -ne "${redColour}[!]${endColour}${grayColour}Saliendoo...${endColour}"
}
if [ "$(id  -u)" == "0" ]; then
	if [ -e /usr/share/wordlists/SecLists/Discovery/DNS/shubs-subdomains.txt ]; then
		echo -e "${yellowColour}[${endColour}${grayColour}!${endColour}${yellowColour}]${endColour} ${grayColour} Revizando  SecLists${endColour}"; sleep 3; clear
		echo -e "${yellowColour}[${endColour}${grayColour}!${endColour}${yellowColour}]${endColour} ${grayColour} Seclist Existe${endColour}"; sleep 3;  clear
else
		echo -e "${yellowColour}[${endColour}${grayColour}!${endColour}${yellowColour}]${endColour} ${grayColour}Clonando SECLISTS${endColour}"
		cd /usr/share/wordlists/ &>/dev/null 
		git clone  https://github.com/danielmiessler/SecLists.git > /dev/null 2>&1
	fi
	sleep 2 ; clear
	echo -ne "${yellowColour}[${endColour}${grayColour}!${endColour}${yellowColour}]${endColour}${grayColour} Seleccione default : ${endColour} "  &&  read diccionario

	echo -ne "${yellowColour}[${endColour}${grayColour}!${endColour}${yellowColour}]${endColour}${grayColour} Nombre del dominio : ${endColour} "  &&  read dominio
	sleep 3; clear

	if [ "$diccionario" == "default" ]; then
		cat /usr/share/wordlists/SecLists/Discovery/DNS/shubs-subdomains.txt | xargs  -P 50 -Itarget bash -c "ping -c1 target.$dominio 2>/dev/null | head  -n 1 | sed 's/PING/[+] SUBDOMAIN/g' |  sort  | uniq  | cut -d  ' ' -f 1,2,3,4 | tr  -d  '()' | sed  's/ / -> /g'"
	else
	echo -e "${yellowColour}[${endColour}${grayColour}!${endColour}${yellowColour}]${endColour} ${grayColour} No reconocido ${endColour}"  
	fi
else 
	echo -e "${yellowColour}[${endColour}${grayColour}!${endColour}${yellowColour}]${endColour}${redColour} No root${endColour}"
fi
