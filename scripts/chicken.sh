#!/bin/bash
set -ex
# select vim dir based on OS
VIM_DIR=".vim"
if [[ "msys" == $OSTYPE ]]; then
  VIM_DIR="vimfiles"
fi

# needs chicken 5
chicken-install r7rs srfi-1 srfi-13 srfi-14 srfi-69
cd $HOME/$VIM_DIR/pack/$USER/start/r7rs-swank/
csi -R r7rs chicken-swank.scm -b -e '(start-swank)'
