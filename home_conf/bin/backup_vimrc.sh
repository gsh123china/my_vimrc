#!/bin/bash

tmpfile="/tmp/.vimrc_backup_lst"

find .vim/ -type f | grep -v "plugged" > ${tmpfile}
tar zcvf vimrc_linux_`date '+%Y%m%d'`.tgz -T ${tmpfile}
\rm ${tmpfile}
