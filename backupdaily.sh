#!/bin/bash
# minecraft server backup script

# read the settings
. ./server.settings

# change to server directory
cd ${serverdirectory}

# adding new daily backup
echo -e "${blue}creating new backup...${nocolor}"
screen -Rd ${servername} -X stuff "say creating new backup...$(printf '\r')"

cp -r -f ${serverdirectory} ${backupdirectory}/daily/${servername}-${new}

# output file location of new daily backup
echo -e "${blue}file available under ${backupdirectory}/daily/${servername}-${new}${nocolor}"
screen -Rd ${servername} -X stuff "say file available under ${backupdirectory}/daily/${servername}-${new}$(printf '\r')"

# deleting old daily backup
echo -e "${red}deleting old backup...${nocolor}"
screen -Rd ${servername} -X stuff "say deleting old backup...$(printf '\r')"

rm -r -f ${backupdirectory}/daily/${servername}-${old}

# output deleted daily backup location
echo -e "${red}deleted ${backupdirectory}/daily/${servername}-${old}${nocolor}"
screen -Rd ${servername} -X stuff "say deleted ${backupdirectory}/daily/${servername}-${old}$(printf '\r')"
