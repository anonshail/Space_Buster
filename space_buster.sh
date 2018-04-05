#!/bin/bash

### SPACE_BUSTER v1.0 ###

#Author : anonshail
#Version : 1.0
#Date written : 5th April, 2018

#This command is to used to find all the files of a given directory and replace the space with an underscore ('_')
#This command has the following options : 
#
# -r -> recursive, works upon all the files in subdirectories of given directory and so on
# -f -> procecsses only the files and not the directories
# -d -> processes only the directories and not the files
#
# Any combination of the above options can be used


#this function replaces all the files bro
#arg1 -> directory path
#arg2 -> recuresive flag
#arg3 -> file flag
#arg4 -> directory flag

function bust_them_spaces {
	#first argument holds the location of the directory in which wan to remove the spaces
	
	FILES=${1}*
	
	#loop to iterate through all the files in the folder
	for FILE in $FILES
	do
		CUR_FILE=$FILE
		if [[ -d ${FILE} ]]	#if the file is a directory
		then
			if [ $4 -eq 1 ]	#checking directory flag
			then
				mv "$FILE" "${FILE// /_}" &> /dev/null
				FILE=${FILE// /_}	#updating path to new path
			fi
			
			if [ $2 -eq 1 ]	#checking recursive flag flag
			then
				bust_them_spaces ${FILE}/ $2 $3 $4			
			fi

		else
			if [ $3 -eq 1 ]	#checking file flag
			then
				mv "$FILE" "${FILE// /_}" &> /dev/null
			fi				
		fi
	done

	#here, we are using parameter search and replace. Basically, in the parameter FILE, all occourences of " " are replaced by a "_".
}

#part of the script where all the tag checking is done

#looping through all the arguments
PV=""
RF=0
FF=0
DF=0

#### NOTE : IF THE RECURSIVE FLAG IS ON, DIRECTORY FLAG MUST COMPULSORILY BE ON, AND WILL BE ASSUMED TO BE ON, EVEN IF MENTIONED AS OFF###

for ARG in $*
do
	if [[ $ARG == -* ]]
	then	
		if [[ $ARG == -*r* ]]	#recursive flag
		then
			RF=1
			DF=1
		fi
		
		if [[ $ARG == -*f* ]]	#file flag
		then		
			FF=1
		fi
	
		if [[ $ARG == -*d* ]]	#directory flag
		then
			DF=1
		fi
	
	else				#path 
		PV=$ARG
	fi
done

#calling the function
bust_them_spaces $PV $RF $FF $DF	





