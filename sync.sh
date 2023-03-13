#!/bin/bash -e

# setup variables
VIM_DIR=".vim"
if [[ "msys" == $OSTYPE ]]; then
  VIM_DIR="vimfiles"
fi  
username=$(whoami)
plugins=$(grep '^http.*$' plugins_list.txt)
plugin_names=$(echo "${plugins}" | cut -d'/' -f5)

echo "=creating directory structure="
mkdir -p plugins
pushd $(pwd)
	cd ~/${VIM_DIR}/
	chmod -R 777 pack/
	rm -fr after plugin autoload pack/${username}/start/
	mkdir -p after plugin autoload pack/${username}/start/
popd

echo "=cleanup stale plugins="
pushd $(pwd)
	cd plugins/
	for oldplugin in $(ls); do
		found="0"
		for truthplugin in "${plugin_names[@]}"); do
			if [[ ${oldplugin} == ${truthplugin} ]]; then
				echo "*found ${oldplugin}"
				found="1"
			fi
		done

		if [[ ${found} == 0 ]]; then
			echo "*purging ${oldplugin}="
			rm -fr ${oldplugin}
		fi
	done
popd

echo "=processing plugins="
pushd $(pwd)
	cd plugins/
	while IFS= read -r plugin; do
		plugin_name=$(echo ${plugin} | cut -d'/' -f5)
		echo "*processing ${plugin_name}"
		if [[ -d "${plugin_name}" ]]; then
			pushd $(pwd)
			echo "*pulling latest ${plugin_name}"
			cd ${plugin_name}
			git pull || echo "something was not happy pulling"
			popd
			continue
		fi

		echo "*cloning ${plugin_name}"
		git clone ${plugin} || echo "something was not happy cloning"
	done < ../plugins_list.txt

	echo "*deploying plugins directory"
	cp -fr * ~/${VIM_DIR}/pack/${username}/start/
popd

echo "=deploying rainbow="
pushd $(pwd)
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
