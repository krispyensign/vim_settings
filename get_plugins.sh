#!/bin/bash
set -ex

plugins=$(cat plugins_list.txt)
plugin_names=$(cat plugins_list.txt | cut -d'/' -f5)

mkdir -p plugins/
cd plugins/

echo $plugin_names

for plugin in $plugins; do
   if [[ $plugin != \#* ]]; then
     git clone $plugin || true
   fi
done

