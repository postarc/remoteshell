#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE="\033[0;34m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m"
PURPLE="\033[0;35m"
MAG='\e[1;35m'
NC='\033[0m'

USERN='root'
SERVER_LIST='ipserver.list'

if [[ "$USERN" == "root" ]]; then
        HOMEFOLDER="/root"
 else
        HOMEFOLDER="/home/$USERN"
fi

if [ -z $1 ]; then echo -e "${RED}Nothing to shell. Exit.${NC}"; exit; fi
if [ ! [-f $SERVER_LIST]];then echo -e "${RED}File $SERVER_LIST not found${NC}"; exit; fi

echo -n -e "${YELLOW}Input Your Root Password:${NC}"
read -e PASSWORD
echo -n -e "${YELLOW}Input The User Name Witch To Run The Script:${NC}"
read -e UNAME

#Проверка установлен ли пакет:
dpkg -s sshpass &>temp.f
if [[ -z $(cat temp.f | grep Version) ]]; then 
  sudo apt-get install -y sshpass > /dev/null 2>&1; fi

#Чтение файла ipserver.list и отправка скриптов:
for IPSERVER in $(<$SERVER_LIST)
do
# sshpass -p "YOUR_PASSWORD" ssh -o StrictHostKeyChecking=no YOUR_USERNAME@SOME_SITE.COM:2400
 
  sshpass -p $PASSWORD scp $1 $USERN@$IPSERVER:$HOMEFOLDER
  sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no $USERN@$IPSERVER chown $USERN:$USERN $HOMEFOLDER/$1
  sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no $USERN@$IPSERVER bash $HOMEFOLDER/$1

done 

#rm -rf remoteshell
rm temp.f
