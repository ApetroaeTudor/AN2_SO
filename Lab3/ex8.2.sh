#!/bin/bash

checkIfFileExists() {
	case $# in
		0) echo "no parameters given!"; exit 1;;
		1) if [ ! -f "$1" ]; then
			echo "file doesn't exist!"; exit 1
                   else
			echo "file exists!"
		fi;;
		*) echo "can't check more than 1 file!"; exit 1;;
	esac
}


echo -e "now choosing the operation!\n arg1 is left operand, arg2 is right operand\n"
echo -e "read the operation, valid inputs are:\n1.sum\n2.subtraction\n3.multiplication\n4.division\n5.modulo"

read input

case $input in
	"sum") checkIfFileExists "Operations/sum.sh" 
		bash Operations/sum.sh $1 $2 ;;
	"subtraction") checkIfFileExists "Operations/subtraction.sh" 
		bash Operations/subtraction.sh $1 $2;;
	"multiplication") checkIfFileExists "Operations/multiplication.sh"
		bash Operations/multiplication.sh $1 $2;;
	"division") checkIfFileExists "Operations/division.sh" 
		bash Operations/division.sh $1 $2;;
	"modulo") checkIfFileExists "Operations/modulo.sh" 
		bash Operations/modulo.sh $1 $2;;
	*)echo "invalid choice!"; exit 1;;
esac
