#!/bin/bash


echo "only the first arg will be converted"


zecimal_hexa() {
	if [ $# -eq 0 ]; then
		echo "no args given!";
	fi

	echo "obase=16; $1"|bc	
}

hexa_zecimal() {
        if [ $# -eq 0 ]; then
                echo "no args given!";
        fi
	str=$1
	echo "ibase=16; ${str^^}"|bc
}
