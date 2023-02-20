#!/bin/bash -e

# select vim dir based on OS
VIM_DIR=".vim"
if [[ "msys" == $OSTYPE ]]; then
  VIM_DIR="vimfiles"
fi  

# Get the username and plugins
username=$(whoami)
plugins=$(cat plugins_list.txt)

echo "=creating directory structure="
rm -fr \
	~/${VIM_DIR}/after 					\
	~/${VIM_DIR}/plugin 					\
	~/${VIM_DIR}/autoload 					\
	~/${VIM_DIR}/pack/${username}/start/
mkdir -p 							\
	plugins/ 						\
	~/${VIM_DIR}/after 					\
	~/${VIM_DIR}/plugin 					\
	~/${VIM_DIR}/autoload 					\
	~/${VIM_DIR}/pack/${username}/start/

pushd $(pwd)
echo "=processing plugins="
cd plugins/
while IFS= read -r plugin; do
	if [[ ${plugin} =~ ^#.*$|^[[:blank:]]*$ ]]; then
		continue
	fi

	plugin_name=$(echo ${plugin} | cut -d'/' -f5)
	echo "=processing ${plugin_name}="
	if [[ -d "${plugin_name}" ]]; then
		pushd $(pwd)
		echo "=${plugin_name} already cloned. updating...="
		cd ${plugin_name}
		git pull || echo "something was not happy pulling"
		popd
		continue
	fi

	echo "=cloning ${plugin_name}="
	git clone ${plugin} || echo "something was not happy cloning"
done < ../plugins_list.txt

# sync plugins directory
echo "=deploying plugins directory="
cp -fr * ~/${VIM_DIR}/pack/${username}/start/
popd

# deploy rainbow
pushd $(pwd)
echo "=configuring rainbow="
cd ~/${VIM_DIR}/pack/${username}/start/rainbow
cp -fr plugin/ autoload/ ~/${VIM_DIR}/
popd

# deploy other addons
echo "=deploying other addons="
cp -fr after/ ~/${VIM_DIR}/after/

# deploy the new vimrc file
echo "=deploying vimrc="
touch ~/.vimrc
cp ~/.vimrc ~/.vimrc.bak
cp vimrc ~/.vimrc
