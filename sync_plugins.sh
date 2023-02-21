#!/bin/bash -e

source ./common.sh

printh "syncing the following plugins"
printf "${YELLOW}${plugin_names}\n"

# make a vim folders
mkdir -p ${pack_folder} ${user_pack_folder}

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
set -x
rsync -pEr ./${pack_folder} ${user_pack_folder}
ls -lah ${user_pack_folder}