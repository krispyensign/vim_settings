#!/bin/bash
set -ex

# select vim dir based on OS
VIM_DIR=".vim"
if [[ "msys" == $OSTYPE ]]; then
  VIM_DIR="vimfiles"
fi  
username=$(whoami)
pack_folder=pack/${username}/start/
user_pack_folder=${vim_dir}${pack_folder}

# Get the username and plugins
echo "Resetting permissions..."
chmod -R 777 ${user_pack_folder}
echo "Purging plugins in home..."
rm -fr ${user_pack_folder}
echo "Purging plugins in project..."
rm -fr ./plugins
echo "Done!"