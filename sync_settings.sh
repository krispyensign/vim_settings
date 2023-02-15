#!/bin/bash
set -ex

# select vim dir based on OS
VIM_DIR=".vim"
if [[ "msys" == $OSTYPE ]]; then
  VIM_DIR="vimfiles"
fi  

# Get the username to deploy the pack files to
username=$(whoami)

# create the directory structure
mkdir -p ~/${VIM_DIR}/after ~/${VIM_DIR}/autoload ~/${VIM_DIR}/plugin

# deploy rainbow
pushd $(pwd)
cd ~/${VIM_DIR}/pack/${username}/start/rainbow
cp plugin/* ~/${VIM_DIR}/plugin
cp autoload/* ~/${VIM_DIR}/autoload
popd

# deploy other addons
cp -fr after/* ~/${VIM_DIR}/after/
cp -fr autoload/* ~/${VIM_DIR}/autoload/

# deploy the new vimrc file
touch ~/.vimrc
cp ~/.vimrc ~/.vimrc.bak
cp vimrc ~/.vimrc

