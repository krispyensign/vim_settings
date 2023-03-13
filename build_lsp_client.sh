#!/bin/bash -e
# select vim dir based on OS
VIM_DIR=".vim"
if [[ "msys" == $OSTYPE ]]; then
  VIM_DIR="vimfiles"
fi
username=$(whoami)

echo "building..."
cd ./plugins/YouCompleteMe
git submodule update --init --recursive
./install.py --all --verbose

echo "deploying..."
chmod -R u+rwx ${pack_folder}/YouCompleteMe
rm -fr ~/${VIM_DIR}/pack/${username}/start/YouCompleteMe
cp -fr ../YouCompleteMe/ ~/${VIM_DIR}/pack/${username}/start/YouCompleteMe
