#!/bin/bash

echo "now doing the sum of 2 numbers!"

case $# in
	0) echo "No args given!"; exit 1; ;;
	1) echo "Sum=$1";;
	2) echo $(($1+$2));;
	*) echo "can't evaluate more than 2 numbers!" ;;
esac
