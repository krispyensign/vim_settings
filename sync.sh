#!/bin/bash -e


function printh() {
	printf "${GREEN}= $1 =${NC}\n"
} 

function prints() {
	printf "${YELLOW}*  $1 ${NC}\n"
}

function printe() {
	printf "${RED}**** $1 ****${NC}"
}

function bluey() {
	printf "${BLUE}"
}

# setup variables
VIM_DIR=".vim"
if [[ "msys" == $OSTYPE ]]; then
  VIM_DIR="vimfiles"
fi  
username=$(whoami)
plugins=$(grep '^http.*$' plugins_list.txt)
plugin_names=$(echo "${plugins}" | cut -d'/' -f5)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color
printh "syncing the following plugins"
printf "${YELLOW}${plugin_names}"

printh "creating directory structure"
mkdir -p plugins ~/${VIM_DIR} 
pushd $(pwd) > /dev/null
	cd ~/${VIM_DIR}/
	chmod -R 777 pack/ || true
	rm -fr after plugin autoload pack/
	mkdir -p after plugin autoload pack/ ~/${VIM_DIR}/pack/${username}/start/
popd > /dev/null

printh "cleanup stale plugins"
pushd $(pwd) > /dev/null
	cd plugins/
	for oldplugin in $(ls); do
		found="0"
		for truthplugin in ${plugin_names[@]}; do
			if [[ ${oldplugin} == ${truthplugin} ]]; then
				prints "found ${oldplugin}"
				found="1"
			fi
		done

		if [[ ${found} == 0 ]]; then
			prints "purging ${oldplugin}="
			rm -fr ${oldplugin}
		fi
	done
popd > /dev/null

printh "processing plugins"
pushd $(pwd) > /dev/null
	cd plugins/
	for plugin in ${plugins[@]}; do
		plugin_name=$(echo ${plugin} | cut -d'/' -f5)
		prints "processing ${plugin_name}"
		if [[ -d "${plugin_name}" ]]; then
			pushd $(pwd) > /dev/null
			prints "pulling latest ${plugin_name}"
			cd ${plugin_name}
			bluey
			git pull || printe "something was not happy pulling"
			popd > /dev/null
			continue
		fi

		prints "cloning ${plugin_name}"
		bluey
		git clone ${plugin} || printe "something was not happy cloning"
	done 

	prints "deploying plugins directory"
	cp -fr * ~/${VIM_DIR}/pack/${username}/start/
popd > /dev/null

printh "deploying rainbow"
pushd $(pwd) > /dev/null
	cd ~/${VIM_DIR}/pack/${username}/start/rainbow
	cp -fr plugin/ autoload/ ~/${VIM_DIR}/
popd > /dev/null

# deploy other addons
printh "deploying other addons"
cp -fr after/ ~/${VIM_DIR}/after/

# deploy the new vimrc file
printh "deploying vimrc"
touch ~/.vimrc
cp ~/.vimrc ~/.vimrc.bak
cp vimrc ~/.vimrc

printh "Done! Use <leader>RR to load new settings without restarting vim :)"