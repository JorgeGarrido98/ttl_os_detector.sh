#!/bin/bash

# Colors (foreground)
RED="\033[1;31m"
GREEN="\033[1;32m"
BLUE="\033[1;34m"
MAGENTA="\033[1;35m"

# Reset
RESET="\033[0m"

# Title Script
echo -e "${MAGENTA}"
cat << "EOF"

 /$$$$$$$$ /$$$$$$$$ /$$              /$$$$$$   /$$$$$$        /$$$$$$$  /$$$$$$$$ /$$$$$$$$ /$$$$$$$$  /$$$$$$  /$$$$$$$$ /$$$$$$  /$$$$$$$ 
|__  $$__/|__  $$__/| $$             /$$__  $$ /$$__  $$      | $$__  $$| $$_____/|__  $$__/| $$_____/ /$$__  $$|__  $$__//$$__  $$| $$__  $$
   | $$      | $$   | $$            | $$  \ $$| $$  \__/      | $$  \ $$| $$         | $$   | $$      | $$  \__/   | $$  | $$  \ $$| $$  \ $$
   | $$      | $$   | $$            | $$  | $$|  $$$$$$       | $$  | $$| $$$$$      | $$   | $$$$$   | $$         | $$  | $$  | $$| $$$$$$$/
   | $$      | $$   | $$            | $$  | $$ \____  $$      | $$  | $$| $$__/      | $$   | $$__/   | $$         | $$  | $$  | $$| $$__  $$
   | $$      | $$   | $$            | $$  | $$ /$$  \ $$      | $$  | $$| $$         | $$   | $$      | $$    $$   | $$  | $$  | $$| $$  \ $$
   | $$      | $$   | $$$$$$$$      |  $$$$$$/|  $$$$$$/      | $$$$$$$/| $$$$$$$$   | $$   | $$$$$$$$|  $$$$$$/   | $$  |  $$$$$$/| $$  | $$
   |__/      |__/   |________/       \______/  \______/       |_______/ |________/   |__/   |________/ \______/    |__/   \______/ |__/  |__/

		                 			    ttl_os_detector.sh - v1.0
                                 		      	      Autor -> Jorge Garrido
EOF
echo -e "${RESET}"

# Code
# --------- Prompt the user to enter an IP address ---------
read -p "Enter the IP address: " IP

# --------- Check if the host is reachable using ping ---------
if ping -c 1 $IP > /dev/null; then
	echo "The host is reachable."

	# --------- Extract the TTL value from the ping response ---------
    	# -c 1 → send 1 ping packet
    	# grep `ttl=` → extract line with TTL info
    	# awk `{print $6}` → get the 6th field (e.g., ttl=64)
    	# tr -d `ttl=` → remove `ttl=` and keep just the number
	TTL=$(ping -c 1 $IP | grep "ttl=" | awk '{print $6}' | tr -d "ttl=")

	echo "The TTL for IP $IP is $TTL"

    	# --------- Basic OS fingerprinting based on TTL value ---------
    	# Linux systems often have TTLs around 64
    	# Windows systems often have TTLs around 128

	if [ $TTL -gt 60 ] && [ $TTL -lt 70 ]; then
		echo -e "${GREEN}The Operating System for IP $IP is likely Linux.${RESET}"
	elif [ $TTL -gt 120 ] && [ $TTL -lt 130 ]; then
		echo -e "${BLUE}The Operating System for IP $IP is likely Windows.${RESET}"
	else
		echo -e "${RED}Could not reliably detect the Operating System for IP $IP${RESET}"
	fi
else
	# If ping fails, the host is unreachable
	echo -e "${RED}No connectivity with IP $IP${RESET}"
fi
