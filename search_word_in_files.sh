#!/bin/bash

## Input: <keyword to search, path, file type> ##
## Output: File names containing the given keyword ##

function search_keyword(){
	local keyword=$1
	local pathName=$2
	local fileType=$3

	## Get list of files with given types ##
	if [ $# -lt 3 ]
	then
		files=`du -a $pathName | awk -F '\t' '{print $2}'`
	else
		files=`du -a $pathName | grep --include={\${fileType}} -e "\${fileType}" | awk -F '\t' '{print $2}'`
	fi

	for f in $files
	do
#		echo $f
		hit=`cat $f 2>/dev/null | grep -i "$keyword"`
		if [ ! -z "$hit" ]
		then
			echo -e "${RED}$f ${BLACK}"
			echo "$hit"
			echo
		fi
	done

}

## Text colour definition ##
BLACK='\033[0;30m'        # Black
RED='\033[0;31m'          # Red
GREEN='\033[0;32m'        # Green

### for i in `du -a | grep --include={\.fxml} -e "\.fxml" | awk -F '\t' '{print $2}'`; do echo $i; cat $i | grep -i "end-to-end"; done

if [ $# -eq 1 ] ## Only keyword is given ##
then
	keyword=$1
	pathName=`pwd` ## Default path ##
	search_keyword $keyword $pathName
elif [ $# -eq 2 ] ## Keyword and path is given##
then
	keyword=$1
	pathName=$2
	search_keyword "$keyword" "$pathName"
elif [ $# -eq 3 ] ## Keyword, path and file type are given ##
then
	keyword=$1
	pathName=$2
	fileType=$3
	search_keyword "$keyword" "$pathName" "$fileType"
else ## Run time parameter missing! ##
	echo -e "Run time parameters are missing!"
fi
