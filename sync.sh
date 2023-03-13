#!/bin/bash -e
# setup variables
vim_dir="${HOME}/.vim/"
if [[ "msys" == $OSTYPE ]]; then
	vim_dir="${HOME}/vimfiles/"
fi
username=$(whoami)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color


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

check_command git
check_command cargo
check_command javac
check_command cmake
check_command python
check_command pip
check_command fzf
check_command go
check_command dlv || true

printh "deploying configs"
mkdir -p ${vim_dir}/autoload ${vim_dir}/after/
cp -fr after/* ${vim_dir}/after/
touch ${HOME}/.vimrc
cp ${HOME}/.vimrc ${HOME}/.vimrc.bak
cp vimrc ${HOME}/.vimrc
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

printh "Done! Use <leader>RR to load new settings without restarting vim :)"
