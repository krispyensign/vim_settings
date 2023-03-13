#!/bin/bash
set -ex

submodules=$(cat plugins_list.txt)
plugin_paths=$(ls plugins/)
for plugin in $plugin_paths; do
  git submodule deinit -f plugins/$plugin
  git rm -fr plugins/$plugin
  rm -fr plugins/$plugin
  rm -fr .git/modules/plugins/$plugin
done

cd plugins

for submodule in $submodules; do
  if [[ $submodule != \#* ]]; then
    git submodule add -f $submodule
  fi
done

