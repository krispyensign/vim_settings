#!/bin/bash
set -ex

# select vim dir based on OS
VIM_DIR=".vim"
if [[ "msys" == $OSTYPE ]]; then
  VIM_DIR="vimfiles"
fi  

# Get the username and plugins
username=$(whoami)
echo "Resetting permissions..."
chmod -R 777 ~/${VIM_DIR}/pack/*
echo "Purging plugins in home..."
rm -fr ~/${VIM_DIR}/pack/*
echo "Purging plugins in project..."
rm -fr ./plugins
echo "Done!"