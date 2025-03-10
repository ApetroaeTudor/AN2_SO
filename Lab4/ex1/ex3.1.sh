#!/bin/bash

#script ce primeste un parametru in linia de comanda si genereaza o structura de proiect

error() {
        echo -e "\033[1mInvalid arguments!\033[0m Please use -h or --help"
        exit 1
}


noArgs() {
	echo -e "Please provide arguments.\n -h for help"
	error
}

help() {
	echo -e "\n\033[1mThis script takes creates a structured project in a directory\033[0m\n"
	echo -e "\033[1mIt takes the following arguments\033[0m\n"
	echo -e "\033[1m1 arg:\033[0m -h or --help OR the name of the project. If no other details are given then the default settings are: C language, one source/inc file\n"
	echo -e "\033[1m2 args:\033[0m ./<script_name>.sh <project_name> <project_language:c/c++> ./<script_name>.sh <project_name> <project_language:c/c++>. Default settings: 1 src/inc file\n"
	echo -e "\033[1m3 args:\033[0m./<script_name>.sh <project_name> <project_language:c/c++> <integer_number:nr of src/inc files>\n"
	echo -e "\033[1m4+ args:\033[0m error\n"
	echo -e "\033[1mWarning:\033[0m creating a project will remove existing directories with the same name!\n" 
	exit 1
}

validateName() {
	regex="^[a-zA-Z0-9_\-]+$"
	invalidStartRegex="^[0-9!@#$%&*^]"
	if [[ "$1" =~ $invalidStartRegex || ! "$1" =~ $regex ]]; then
		echo "invalid file name"
		error
	fi
}

checkIfIsHelpArg() {
	if [[ "$1" == "-h" || "$1" == "--help" ]]; then
		help
		exit 1
	fi
}



validateLanguage() {
        regex="^[cC]{1}(\+\+){0,1}$|^cpp$|^CPP$|^Cpp$"
        if [[ ! "$1" =~ $regex ]]; then
                echo "invalid language choice"
                error
        fi
}

languageType="Undefined"

getLanguageType() { #0 is c, 1 is cpp
	regexC="^[cC]{1}$"
	regexCpp="^[cC]{1}(\+\+){1}$|^cpp$|^CPP$|^Cpp$"
	if [[ "$1" =~ $regexC  ]]; then
		languageType="c"
	fi
	if [[ "$1" =~ $regexCpp ]]; then
		languageType="cpp"
	fi
}

validateNumber() {
	regexNr="^[1-9]+[0-9]?$"
	if [[ ! $1 =~ $regexNr ]]; then
		echo "given parameter is not a number"
		error
	fi
}

writeFiles() {
	prjname="$1"
	language="$2"
	nr="$3"

	if [ -d "${prjname}" ]; then
		rm -r "${prjname}"
	fi


	mkdir "${prjname}" "${prjname}/bin" "${prjname}/obj"
	mkdir "${prjname}/src" "${prjname}/inc"

	touch  "${prjname}/${prjname}.${language}" "${prjname}/${prjname}.h"; touch "${prjname}/build.sh"
	i=1
	while [ $i -le $nr ]; do
		touch "${prjname}/src/${prjname}_src${i}.${language}" "${prjname}/inc/${prjname}_inc${i}.h"
		i="`expr ${i} + 1`"
	done
}




case $# in
	0) noArgs ;;

	1) checkIfIsHelpArg "$1" 
	   validateName "$1"
	   writeFiles "$1" "c" "1";;

	2) validateName "$1"
	   validateLanguage "$2"
	   getLanguageType "$2"
	   writeFiles "$1" "$languageType" "1";;

	3) validateName "$1"
	   validateLanguage "$2"
           getLanguageType "$2"
	   validateNumber "$3"
	   writeFiles "$1" "$languageType" "$3";;
	*) error;;

esac
