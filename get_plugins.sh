#!/bin/bash
set -ex

rm -rf plugins/

plugins=$(cat plugins_list.txt)

mkdir -p plugins/
cd plugins/

for plugin in $plugins; do
   if [[ $plugin != \#* ]]; then
     git clone $plugin
   fi
done

