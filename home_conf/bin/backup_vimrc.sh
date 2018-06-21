#!/bin/bash

nowdir=${PWD}
vimdir="${HOME}/.vim"
date=$(date +%Y%m%d)
backfile="vimrc_linux_${date}.tgz"

cd ${vimdir}
git archive master --prefix='.vim/' --format=tgz > ${nowdir}/${backfile}
cd ${nowdir}
tar tvf ${backfile}
