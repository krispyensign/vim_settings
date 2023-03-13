#!/bin/bash
set -ex

# select vim dir based on OS
VIM_DIR=".vim"
if [[ "msys" == $OSTYPE ]]; then
  VIM_DIR="vimfiles"
fi  

# Get the username to deploy the pack files to
username=$(whoami)

# sync plugins directory
mkdir -p ~/${VIM_DIR}/pack/${username}/start/
rm -fr ~/${VIM_DIR}/pack/${username}/start/*
cp -fr plugins/* ~/${VIM_DIR}/pack/${username}/start/
