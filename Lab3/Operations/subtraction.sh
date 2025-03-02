#!/bin/bash

echo "now doing subtraction of 2 numbers!"

case $# in 
	0) echo "no args given"; exit 1; ;;
	1) echo "$1" ;;
	2) echo $(($1-$2)) ;;
	*) echo "can't evaluate more than 2 parameters" ;;
esac
