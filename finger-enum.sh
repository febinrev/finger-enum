#!/bin/bash


RESTORE=$(echo -en '\033[0m')
RED=$(echo -en '\033[00;31m')
GREEN=$(echo -en '\033[00;32m')
YELLOW=$(echo -en '\033[00;33m')
BLUE=$(echo -en '\033[00;34m')
MAGENTA=$(echo -en '\033[00;35m')
PURPLE=$(echo -en '\033[00;35m')
CYAN=$(echo -en '\033[00;36m')
LIGHTGRAY=$(echo -en '\033[00;37m')
LRED=$(echo -en '\033[01;31m')
LGREEN=$(echo -en '\033[01;32m')
LYELLOW=$(echo -en '\033[01;33m')
LBLUE=$(echo -en '\033[01;34m')
LMAGENTA=$(echo -en '\033[01;35m')
LPURPLE=$(echo -en '\033[01;35m')
LCYAN=$(echo -en '\033[01;36m')
WHITE=$(echo -en '\033[01;37m')

banner(){
echo ${LGREEN}
printf "
╔═╗┬┌┐┌┌─┐┌─┐┬─┐   ╔═╗┌┐┌┬ ┬┌┬┐
╠╣ │││││ ┬├┤ ├┬┘───║╣ ││││ ││││
╚  ┴┘└┘└─┘└─┘┴└─   ╚═╝┘└┘└─┘┴ ┴"

echo ${LCYAN}
printf "               Author: Febin Twitter: @febinrev\n"
echo ${LMAGENTA}
printf "  Simple Tool to enumerate users from Fingerd service\n\n"                                                                     
echo ${RESTORE}


}
help(){
banner
echo "Usage: $0 <USERFILE> <TARGET> [PORT (default 79)]"

}

finger(){

find=$(echo "$1" | nc "$2" "$3" | grep -v "no such user")

 if [ $? -eq 0 ]
 then
    printf "$1\n" >> /tmp/${0}.found_users.log
    printf "Found User: $1\n"
    printf "*******************************************************\n"
    found=$find
    printf "$found"
    printf "*******************************************************\n\n"
 fi

}

enum(){
userfile="$1"
target="$2"
port="$3"

for user in $(cat $userfile)
do
	finger "$user" "$target" "$port"
done

}

scan(){
echo ${LGREEN}
printf "    FINGER-ENUM STARTED\n"
echo ${RESTORE}
if [ -r $1 ] && [ $2 ] && [ $3 ]
then
	enum "$1" "$2" "$3" 2>/dev/null
elif [ -r $1 ] && [ $2 ]
then
	enum "$1" "$2" 79 2>/dev/null
else
	help
fi

}


if [ -f /tmp/${0}.found_users.log ]
then
 rm -f /tmp/${0}.found_users.log
fi

scan $1 $2 $3  



if [ -f /tmp/${0}.found_users.log ]
then
  printf "List of Found Users:\n"
  printf "=========================\n\n"
  cat /tmp/${0}.found_users.log
  rm -f /tmp/${0}.found_users.log
fi



