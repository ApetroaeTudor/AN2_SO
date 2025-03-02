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


if [ $# -eq 1 ]; then
	echo "because only one argument was given, the program will convert decimal->hex and hex<-decimal"
	echo -e "Pick functionality(input nr 1 or 2):\n1.decimal->hex\n2.hex->decimal"
	read choice
	case $choice in
		"1") checkIfFileExists "ex8.3.sh"
                     . ex8.3.sh
                     zecimal_hexa $1;;
		"2") checkIfFileExists "ex8.3.sh"
                     . ex8.3.sh
                     hexa_zecimal $1;;
		*) echo "invalid choice" ;;
	esac
else
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


fi

