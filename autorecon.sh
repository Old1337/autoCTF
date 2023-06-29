#!/bin/bash
DOMAIN=$1
DIR=$(echo $1 | cut -d '.' -f1)
FULL_PATH=~/bugbounty/$DIR

# colors
GREEN="\e[92m"
BLUE="\e[36m"
DEFAULT="\e[0m"
BOLD="\e[1m"
RED="\e[31m"


# github
TOKEN="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"

function github_recon() {

 echo -e "$BLUE$BOLD [!] doing github recon....$DEFAULT"

 github-subdomains  -d $DOMAIN -t $TOKEN > github

 echo -e "$GREEN$BOLD [+] successfully finished github recon $DEFAULT"


}

function wayback() {

 echo -e "$BLUE$BOLD [!] gahtering endpoints from waybackmachine....$DEFAULT"

    waybackurls $DOMAIN > wayback

 echo -e "$GREEN$BOLD [+] successfully finished  $DEFAULT"

}

function general_recon() {

    echo -e "$BLUE$BOLD [!] running subfinder....$DEFAULT"

    subfinder -d $DOMAIN > subfinder

    echo -e "$GREEN$BOLD [+] successfully finished running subfinder $DEFAULT"

}

function init() {
    mkdir $FULL_PATH
    cd $FULL_PATH



    github_recon
    wayback
    general_recon

}





init



