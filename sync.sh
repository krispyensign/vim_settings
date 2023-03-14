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

pushd () {
    command pushd "$@" > /dev/null
}

popd () {
    command popd "$@" > /dev/null
}

function printh() {
	printf "${GREEN}= $1 =${NC}\n"
}

function prints() {
	printf "${YELLOW}*  $1 ${NC}\n"
}

function printe() {
	printf "${RED}**** $1 ****${NC}\n"
}

function bluey() {
	printf "${BLUE}"
}

function check_command() {
	if ! type "$1" > /dev/null; then
		printe "cannot find $1"
		if [[ "$2" != "warn" ]]; then
			return -1
		fi
		return 0
	fi
	prints "found $1"
	return 0
}

function get_latest_version() {
	curl --silent "https://api.github.com/repos/$1/releases/latest" | jq -r .tag_name
}

function get_omnisharp() {
	omnisharp_path=${vim_dir}/contrib/omnisharp
	omnisharp_version=$(get_latest_version "OmniSharp/omnisharp-roslyn")
	omnisharp_version_lock=${vim_dir}/contrib/omnisharp-${omnisharp_version}
	if [[ ! -f ${omnisharp_version_lock} ]]; then
		mkdir -p ${omnisharp_path}
		case "${OSTYPE}" in
			darwin*) platform=osx ;;
			linux*) platform=linux ;;
			msys*) platform=win ;;
			cygwin*) platform=win ;;
			mingw*) platform=win ;;
			*) platform=unknown ;;
		esac
		# TODO: detect arch
		omnisharp_filename=omnisharp-${platform}-x64-net6.0.tar.gz
		pushd ${omnisharp_path}
			wget -O omnisharp.tar.gz -v\
				https://github.com/OmniSharp/omnisharp-roslyn/releases/download/${omnisharp_version}/${omnisharp_filename}
			tar xvfz omnisharp.tar.gz
		popd
		touch ${omnisharp_version_lock}
	else
		prints "omnisharp up to date"
	fi
}

function get_golangci() {
	golangci_path=$(go env GOPATH)/bin 
	golangci_version=$(get_latest_version "golangci/golangci-lint")
	golangci_version_lock=${vim_dir}/contrib/golangci-${golangci_version}
	if [[ ! -f ${golangci_version_lock} ]]; then
		curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh\
			| sh -s -- -b ${golangci_path} ${golangci_version}
		touch ${golangci_version_lock}
	else
		prints "golangci-lint up to date"
	fi
}

function get_vimplug() {
	if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	else
		prints "vim plug already exists, upgrade at any time with PU command"
	fi
}

function deploy_configs() {
	prints "deploying configs"
	mkdir -p ${vim_dir}/autoload ${vim_dir}/after/
	cp -fr after/* ${vim_dir}/after/
	touch ${HOME}/.vimrc
	cp ${HOME}/.vimrc ${HOME}/.vimrc.bak
	cp vimrc ${HOME}/.vimrc
}

printh "syncing vim settings"

prints "checking available commands"
check_command git
check_command node
check_command npm
check_command cargo
check_command javac
check_command cmake
check_command python
check_command pip
check_command go

deploy_configs

get_vimplug
get_golangci
# get_omnisharp

# TODO: manually manage all LSPs??

printh 'Done! Use <leader>RR to load new settings without restarting vim :)'
