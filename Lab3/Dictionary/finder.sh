#!/bin/bash


pathToFile=$(pwd)
echo $pathToFile

canOpenDictionary() {
	if [ ! -f "dictionary" ]; then
		echo "file not defined"
	else
		echo "file exists"
	fi
}


case $# in
	0) echo "no args given"; exit 1 ;;
	1) canOpenDictionary

	   FoundWords="undefined word"

	   FoundWords=$(grep -wo "$1" dictionary)

	   counter=0

	   for i in $FoundWords; do
		counter=$(echo "$counter+1" | bc)
		myWord=$i
	   done

	   echo "Found the word $myWord: $counter times" 
		;;
	*) echo "too many args given"; exit 1;;
esac
