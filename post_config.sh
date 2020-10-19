#!/bin/bash
set -ex

# select vim dir based on OS
VIM_DIR=".vim"
if [[ "msys" == $OSTYPE ]]; then
  VIM_DIR="vimfiles"
fi  

# Get the username to deploy the pack files to
username=$(whoami)

# configure language client
pushd $(pwd)
cd ~/${VIM_DIR}/pack/${username}/start/LanguageClient-neovim/
if [[ "msys" == $OSTYPE ]]; then
  powershell -File install.ps1
else
  ./install.sh
fi
popd

# configure rainbow
pushd $(pwd)
cd ~/${VIM_DIR}/pack/${username}/start/rainbow
cp plugin/* ~/${VIM_DIR}/plugin
cp autoload/* ~/${VIM_DIR}/autoload
popd
