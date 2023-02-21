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

function check_command() {
	if ! type "$1" > /dev/null; then
		echo "cannot find $1"
		exit -1
	fi
}

check_command rsync
check_command git

# setup variables
vim_dir="${HOME}/.vim/"
if [[ "msys" == $OSTYPE ]]; then
	vim_dir="${HOME}/vimfiles/"
fi
username=$(whoami)
pack_folder=pack/${username}/start/
user_pack_folder=${vim_dir}${pack_folder}
plugins=$(grep '^http.*$' plugins_list.txt)
plugin_names=$(echo "${plugins}" | cut -d'/' -f5)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

printh "detected vim pack folder ${user_pack_folder}"

printh "syncing the following plugins"
printf "${YELLOW}${plugin_names}\n"

# make a vim folder if there isn't one already
mkdir -p ${user_pack_folder}

printh "cleanup stale plugins"
for oldplugin in $(ls ./${pack_folder}); do
	found="0"
	for truthplugin in ${plugin_names[@]}; do
		if [[ ${oldplugin} == ${truthplugin} ]]; then
			prints "found ${oldplugin}"
			found="1"
		fi
	done

	if [[ ${found} == 0 ]]; then
		prints "purging ${oldplugin}="
		rm -fr ./${pack_folder}${oldplugin}
	fi
done

printh "processing plugins"
for plugin in ${plugins[@]}; do
	plugin_name=$(echo ${plugin} | cut -d'/' -f5)
	prints "processing ${plugin_name}"
	if [[ -d "${pack_folder}${plugin_name}" ]]; then
		prints "pulling latest ${plugin_name}"
		bluey
		pushd $(pwd) > /dev/null
			cd ${pack_folder}${plugin_name}
			git pull || printe "failed pulling ${plugin_name}"
		popd > /dev/null
		continue
	fi

	prints "cloning ${plugin_name}"
	bluey
	git clone ${plugin} ${pack_folder}${plugin_name} || printe "failed cloning ${plugin_name}"
done 

prints "deploying plugins directory"
rsync -pE ./${pack_folder} ${user_pack_folder}

# deploy other addons
printh "deploying other addons"
cp -fr after/ ${vim_dir}/after/

# deploy the new vimrc file
printh "deploying vimrc"
touch ${HOME}/.vimrc
cp ${HOME}/.vimrc ${HOME}/.vimrc.bak
cp vimrc ${HOME}/.vimrc

printh "Done! Use <leader>RR to load new settings without restarting vim :)"