#!/bin/bash
set -ex

rm -rf plugins/

plugins=$(cat plugins_list.txt)

mkdir -p plugins/
cd plugins/

for submodule in $plugins; do
   if [[ $submodule != \#* ]]; then
     git clone $submodule
   fi
done

