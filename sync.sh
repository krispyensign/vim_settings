#!/bin/bash -e

# select vim dir based on OS
VIM_DIR=".vim"
if [[ "msys" == $OSTYPE ]]; then
  VIM_DIR="vimfiles"
fi  

# Get the username and plugins
username=$(whoami)
plugins=$(cat plugins_list.txt)
plugin_names=$(cat plugins_list.txt | cut -d'/' -f5)

mkdir -p plugins/

pushd $(pwd)
cd plugins/

while IFS= read -r plugin; do
	if ! [[ $plugin =~ ^#.*$|^[[:blank:]]*$ ]]; then
		echo "found $plugin..."
		git clone $plugin || true
   	fi
done < ../plugins_list.txt

# sync plugins directory
mkdir -p ~/${VIM_DIR}/pack/${username}/start/
cp -fr * ~/${VIM_DIR}/pack/${username}/start/

# create the directory structure
mkdir -p ~/${VIM_DIR}/after ~/${VIM_DIR}/autoload ~/${VIM_DIR}/plugin
popd

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

