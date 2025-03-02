#!/bin/bash

echo "now doing modulo of 2 numbers!"

case $# in
	0) echo "no args given!" exit ;;
	1) echo "$1";;
	2) if [ $2 -eq 0 ]; then 
		echo "can't divide by 0!"; exit 1;
	fi;;
	
	*) echo "can't evaluate more than 2 numbers!";;
esac
