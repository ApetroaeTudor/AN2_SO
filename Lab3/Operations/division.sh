#!/bin/bash

echo "now doing division of 2 numbers!"

case $# in
	0) echo "No args given"; exit 1;;
	1) echo "$1";;
	2) if [ $2 -eq 0 ]; then
		echo "division by 0!"; exit 1
           fi
		echo $(($1/$2));;
	*) echo "can't evaluate more than 2 numbers!" ;;
esac
