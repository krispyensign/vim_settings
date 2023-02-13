#!/bin/bash
set -ex

# select vim dir based on OS
VIM_DIR=".vim"
if [[ "msys" == $OSTYPE ]]; then
  VIM_DIR="vimfiles"
fi  

# Get the username to deploy the pack files to
username=$(whoami)

# configure rainbow
pushd $(pwd)
cd ~/${VIM_DIR}/pack/${username}/start/rainbow
mkdir -p ~/${VIM_DIR}/plugin ~/${VIM_DIR}/autoload || true
cp plugin/* ~/${VIM_DIR}/plugin
cp autoload/* ~/${VIM_DIR}/autoload
popd

