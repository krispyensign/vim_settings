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
mkdir -p ~/${VIM_DIR}/pack/${username}/start/
mkdir -p ~/${VIM_DIR}/after
mkdir -p ~/${VIM_DIR}/autoload
mkdir -p ~/.local/share/nvim/
mkdir -p ~/.local/bin/

# Purge any files in the start folder
rm -fr ~/${VIM_DIR}/pack/${username}/start/*

# deploy the plugins and addons
cp -fr plugins/* ~/${VIM_DIR}/pack/${username}/start/
cp -fr after/* ~/${VIM_DIR}/after/
cp -fr autoload/* ~/${VIM_DIR}/autoload/
cp -fr scripts/* ~/.local/vim_scripts/

# make scripts executable
chmod +x ~/.local/vim_scripts/*

# deploy the new vimrc file
cp ~/.vimrc ~/.vimrc.bak
cp vimrc ~/.vimrc
