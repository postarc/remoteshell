#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE="\033[0;34m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m"
PURPLE="\033[0;35m"
MAG='\e[1;35m'
NC='\033[0m'

echo -n -e "${YELLOW}Input Your Root Password:${NC}"
read -e PASSWORD
echo -n -e "${YELLOW}Input The User Name Witch To Run The Script:${NC}"
read -e UNAME

#Проверка установлен ли пакет:
dpkg -s sshpass &>temp.f
if [[ -z $(cat temp.f | grep Version) ]]; then 
  sudo apt-get install -y sshpass 2>&1; fi

#Чтение файла ipserver.list и отправка скриптов:
for IPSERVER in $(<ipserver.list)
do
 

   
      
done 
rm temp.f
