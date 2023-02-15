#!/bin/bash
set -ex

# select vim dir based on OS
VIM_DIR=".vim"
if [[ "msys" == $OSTYPE ]]; then
  VIM_DIR="vimfiles"
fi  

# Get the username to deploy the pack files to
username=$(whoami)

plugins=$(cat plugins_list.txt)
plugin_names=$(cat plugins_list.txt | cut -d'/' -f5)

mkdir -p plugins/
cd plugins/

echo $plugin_names

for plugin in $plugins; do
   if [[ $plugin != \#* ]]; then
     git clone $plugin || true
   fi
done

# sync plugins directory
mkdir -p ~/${VIM_DIR}/pack/${username}/start/
sudo rm -fr ~/${VIM_DIR}/pack/${username}/start/*
cp -fr * ~/${VIM_DIR}/pack/${username}/start/
