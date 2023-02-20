#!/bin/bash -e

# setup variables
VIM_DIR=".vim"
if [[ "msys" == $OSTYPE ]]; then
  VIM_DIR="vimfiles"
fi  
username=$(whoami)
plugins=$(grep '^http.*$' plugins_list.txt)
plugin_names=$(echo "${plugins}" | cut -d'/' -f5)
echo "=syncing the following plugins="
echo "${plugin_names}"

echo "=creating directory structure="
mkdir -p plugins ~/${VIM_DIR} 
pushd $(pwd) > /dev/null
	cd ~/${VIM_DIR}/
	chmod -R 777 pack/ || true
	rm -fr after plugin autoload pack/
	mkdir -p after plugin autoload pack/ ~/${VIM_DIR}/pack/${username}/start/
popd > /dev/null

echo "=cleanup stale plugins="
pushd $(pwd) > /dev/null
	cd plugins/
	for oldplugin in $(ls); do
		found="0"
		for truthplugin in ${plugin_names[@]}; do
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
popd > /dev/null

echo "=processing plugins="
pushd $(pwd) > /dev/null
	cd plugins/
	for plugin in ${plugins[@]}; do
		plugin_name=$(echo ${plugin} | cut -d'/' -f5)
		echo "*processing ${plugin_name}"
		if [[ -d "${plugin_name}" ]]; then
			pushd $(pwd) > /dev/null
			echo "*pulling latest ${plugin_name}"
			cd ${plugin_name}
			git pull || echo "something was not happy pulling"
			popd > /dev/null
			continue
		fi

		echo "*cloning ${plugin_name}"
		git clone ${plugin} || echo "something was not happy cloning"
	done 

	echo "*deploying plugins directory"
	cp -fr * ~/${VIM_DIR}/pack/${username}/start/
popd > /dev/null

echo "=deploying rainbow="
pushd $(pwd) > /dev/null
	cd ~/${VIM_DIR}/pack/${username}/start/rainbow
	cp -fr plugin/ autoload/ ~/${VIM_DIR}/
popd > /dev/null

# deploy other addons
echo "=deploying other addons="
cp -fr after/ ~/${VIM_DIR}/after/

# deploy the new vimrc file
echo "=deploying vimrc="
touch ~/.vimrc
cp ~/.vimrc ~/.vimrc.bak
cp vimrc ~/.vimrc

echo "use <leader>RR to load new settings without restarting vim :)"