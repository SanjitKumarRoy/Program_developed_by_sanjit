#!/bin/bash


##Take backup of (copy) following directories##
##Give relative path name removing '~/', that is path name starting from home directory##
#directory="Documents Sanjit/cplex Sanjit/Program/Shell_script"
#directory="Sanjit Dropbox Desktop Documents Music Downloads"
directory="Sanjit Desktop Documents Music Downloads"

##Colour definitation##
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'

##Get the mount point for the external disk drive##
#externalHDDpath=`df | grep -i "/dev/sdb" | awk '{print $6}'`
externalHDDpath=`df | gr\ep -i "/dev/sdb" | awk '{printf "%s", $6} END {for(i = 7; i <= NF; i++) {printf " %s", $i}}'`

OLD_PATH=`pwd`

##Get into the external HDD##
if [ ! -z "$externalHDDpath" ]
then
	echo -e "\n${BLUE}PATH_TO_EXTERNAL_DISK: \"$externalHDDpath\"${BLACK}"

	##Go to the external hard disk##
	cd "${externalHDDpath}"
	
	##Create a directory in the external hard disk, if there is no directory with the current computer name##
	hName=`ls | grep -i "$HOSTNAME"`
	if [ "$hName" != "$HOSTNAME" ]
	then
		mkdir $HOSTNAME
		echo -e "${GREEN}Directory named \"$HOSTNAME\" is created${BLACK}"
	else
		echo -e "\n${GREEN}Directory \"$hName\" exists${BLACK}"
	fi

	##Get into the directory with current computer name##
	cd $HOSTNAME
	
	for d in $directory
	do
	##Make parent directories in the path##
	mkdir -p ${d}
		cp -r -u -v ~/${d}/* ./${d}/
	done
	
	echo -e "\n${GREEN}Backup taken successfully!${BLACK}\n"

else
	echo -e "\n${RED}Error! External memory not found!${BLACK}\n"
fi

cd $OLD_PATH
echo -e "${BLUE}PRESENT_WORKING_DIRECTORY: \"`pwd`\"${BLACK}\n"
