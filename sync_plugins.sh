#!/bin/bash
set -ex

# select vim dir based on OS
VIM_DIR=".vim"
if [[ "msys" == $OSTYPE ]]; then
  VIM_DIR="vimfiles"
fi  

# Get the username to deploy the pack files to
username=$(whoami)

# create plugins directory
mkdir -p ~/${VIM_DIR}/pack/${username}/start/

# create helper folders
mkdir -p ~/.local/share/nvim/
mkdir -p ~/.local/vim_scripts/


# Purge any files in the start folder
rm -fr ~/${VIM_DIR}/pack/${username}/start/*

# deploy
cp -fr plugins/* ~/${VIM_DIR}/pack/${username}/start/
cp -fr scripts/* ~/.local/vim_scripts/

# make scripts executable
chmod +x ~/.local/vim_scripts/*
