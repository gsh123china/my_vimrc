#!/bin/bash

declare -a filelst=$(find . -name "Makefile" -o -name "makefile")

for file in ${filelst}
do
	echo ${file}
	awk '/# DO NOT DELETE/{print $0; exit} {print $0}' ${file} > ${file}_tmp
	\mv ${file}_tmp ${file}
done
