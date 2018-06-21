#!/bin/bash

tmpfile=$(mktemp -t)

function finish {
	\rm -f ${tmpfile}
}

find .vim/ -type f | grep -v "plugged" > ${tmpfile}
tar zcvf vimrc_linux_`date '+%Y%m%d'`.tgz -T ${tmpfile}
trap finish EXIT
