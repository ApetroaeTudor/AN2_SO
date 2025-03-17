#!/bin/bash

showMainMenu() {
echo -e "\n\e[0;35mMenu:\e[0m"
echo "--- 1 --- Edit file"
echo "--- 2 --- Compile"
echo "--- 3 --- Show previous errors"
echo "--- 4 --- Run compiled program"
echo "--- 5 --- Exit"
}

chooseCompiler() {
echo -e "\e[0;35mChoose Compiler:\e[0m"
case $1 in
	0) echo "--- 1 --- g++"
	       echo "--- 2 --- clang++" ;;
	1) echo "--- 1 --- gcc"
             echo "--- 2 --- clang" ;;
esac
}

yesNoMenu() {
	echo " --- 1 --- yes"
	echo " --- 2 --- no"
}
