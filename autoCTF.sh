#!/bin/bash

DIR=~/CTF/Boxes/ # Root DIR
BOX=${1^}
IP=$2

# colors
GREEN="\e[92m"
BLUE="\e[36m"
DEFAULT="\e[0m"
BOLD="\e[1m"
RED="\e[31m"

function welcome_msg() {
    printf $BOLD$GREEN
    figlet -c -t "WELCOME BACK $USER, LET'S DO SOME HACKING!"
    printf $DEFAULT
}


function init() {
    check_connection

    echo -e "$BLUE$BOLD [!] Creating a directory...\n $DEFAULT"

    if [ -d "${DIR}${BOX}" ]; then
        echo -e "$RED$BOLD [-] Failed to make $BOX directory. $BOX directory already exists.\n$DEFAULT"
        exit 1

        elif  [ -z $IP ]; then
        echo -e "$RED$BOLD [-] Error, IP cannot Be Empty$DEFAULT"
        exit 1

    else
        mkdir ${DIR}${BOX}
        echo -e "$GREEN$BOLD [+] Successfully created the ${BOX} directory$DEFAULT"
        scan_host
    fi
}

function check_connection() {

    echo -e "$BLUE$BOLD [!] Checking VPN Connection ...\n $DEFAULT"

    ip a show tun0 >/dev/null 2>&1
    if [ $? -ne 0 ]; then

    echo -e "$RED$BOLD [-] Please Connect To openVPN \n$DEFAULT"

    exit 1

    fi
}

function scan_host() {
    
        echo -e "$BLUE$BOLD [!] Scanning host....$DEFAULT"
        # Light Scan
        nmap -sV -sC -vvv $IP -o "${DIR}${BOX}/scan"
        
        echo -e "$GREEN$BOLD [+] $IP  has been scanned successfully and output file was saved to ${DIR}${BOX}/scan directory.$DEFAULT"

        # deep scan
        nmap $IP -p- -o "${DIR}${BOX}/deep-scan" > /dev/null &

        # Move to box directory
        cd ${DIR}${BOX}
        $SHELL

}

welcome_msg
init

