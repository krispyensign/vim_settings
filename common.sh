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