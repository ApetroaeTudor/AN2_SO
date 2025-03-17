#!/bin/bash

source menuDisplayer.sh

error() {
	echo -e "\e[0;35mError. Message: $1\e[0m"
	exit 1
}

exitNormally() {
	echo -e "\e[0;35mExiting.. \n$1 \e[0m"
	exit 0
}

validateFileParameter() {
	if [[ $1 =~ ^[a-zA-Z]+[\d]*[a-zA-Z]*\.(cpp|c)$ ]];
		then
			return 1
		else
			return 0
	fi
}

getFileExtensionType() {
	if [[ $1 =~ .*\.cpp$ ]]; then
		return 0
	fi
	if [[ $1 =~ .*\.c$ ]]; then
		return 1
	fi

	error "invalid extension type"
}

createFileFromGivenArg() {
	validateFileParameter "$1"
	isValid=$?
	if [ $isValid -eq 1 ]; then
		touch $1
	else
		error "Invalid file name or extension"
	fi
}

checkIfFileExists() {
	if [ -f "$1" ]; then
		return 1
	else
		return 0
	fi
}


loadedFile="Unloaded" 

loadFileForCompilation() {
	validateFileParameter "$1"
	isValid=$?
	if [ $isValid -eq 1 ]; then
		checkIfFileExists "$1"
		exists=$?
		if [ $exists -eq 0 ]; then
			createFileFromGivenArg "$1"
		fi
		loadedFile="$1"
		return 1
	else
		echo "Parameter given invalid. Create a new file?"
		yesNoMenu
		read UserChoice
		case $UserChoice in
			1) echo "Read file name with extension. Allowed extensions are: .c and .cpp"
			   read fileName
			   validateFileParameter $fileName
			   isValid=$?
			   echo "$isValue"
			   if [ $isValid -eq 0 ]; then
			   	error "$fileName is not a valid file name"
			   fi
			    createFileFromGivenArg $fileName
			    loadedFile=$fileName
				 ;;
			2) exitNormally  ;;
			*) error "Invalid choice" ;;
		esac
		 
	fi

}

compileClang() {
	clang -Wall -Wextra -o $2 $1 2>&1 | tee errors.err
}

compileClangPP() {
	clang++ -Wall -Wextra -o $2 $1 2>&1 | tee errors.err
}

compileGcc() {
	gcc -Wall -Wextra -o $2 $1 2>&1 | tee errors.err
}

compileGPP() {
	g++ -Wall -Wextra -o $2 $1 2>&1 | tee errors.err
}

compileMyFile() {
	fileNameNoExtension=$(echo "$loadedFile" | cut -d "." -f 1)
	getFileExtensionType "$1"
	fileExtension=$?
	chooseCompiler "$fileExtension"

	if [ -f $fileNameNoExtension ]; then rm $fileNameNoExtension; fi;
	if [ -f "errors.err" ]; then rm errors.err; fi;
	touch errors.err
	read compilerChoice
	case $compilerChoice in
	1) if [ $fileExtension -eq 0 ]; then compileGPP "$loadedFile" "$fileNameNoExtension"; fi;
	   if [ $fileExtension -eq 1 ]; then compileGcc "$loadedFile" "$fileNameNoExtension"; fi;
		;;
	2) if [ $fileExtension -eq 0 ]; then compileClang "$loadedFile" "$fileNameNoExtension"; fi; 
           if [ $fileExtension -eq 1 ]; then compileClangPP "$loadedFile" "$fileNameNoExtension"; fi;
		;;
	*) error "Invalid compiler choice"
	esac
}
loadFileForCompilation "$1"

echo -e "\e[0;35mCurrently Loaded File is: $loadedFile\n\e[0m"

showMainMenu

echo -e "\nInput your choice --1 to 5--"

read userChoice

while true; do

case $userChoice in
	1) nano $loadedFile;;
	2) compileMyFile $loadedFile;;
	3) if [ -e errors.err ]; then cat errors.err; else echo "No errors file exists at the moment"; fi; ;;
	4) fileNameNoExtension=$(echo "$loadedFile" | cut -d "." -f 1)
	   if [ -e $fileNameNoExtension ]; then
		./$fileNameNoExtension
	   else
		echo "File hasn't been compiled yet"
	  fi ;;
	5) break  ;;
	*) ;;

esac

showMainMenu
read userChoice

done

exitNormally
