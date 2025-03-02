#!/bin/bash

if [ $# -eq 0  ]; then
	echo "No args provided"
	exit 1;
fi

nrargs=$#
allargs=("$@")

i=$nrargs

while [ $i -gt 0 ]; do
	i=$((i-1))
	echo "${allargs[$i]}" 
done

