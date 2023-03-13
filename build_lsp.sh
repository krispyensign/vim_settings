#!/bin/bash -ex
# select vim dir based on OS
VIM_DIR=".vim"
if [[ "msys" == $OSTYPE ]]; then
  VIM_DIR="vimfiles"
fi  

# Get the username and plugins
username=$(whoami)

cd ./plugins/YouCompleteMe
git submodule update --init --recursive
./install.py --all

rm -fr ~/${VIM_DIR}/pack/${username}/start/YouCompleteMe
cp -fr ../YouCompleteMe/ ~/${VIM_DIR}/pack/${username}/start/YouCompleteMe
