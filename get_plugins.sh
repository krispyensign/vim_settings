#!/bin/bash
submodules=$(cat submodules_list.txt)
cd plugins
for submodule in $submodules; do
  git submodule add $submodule
done

