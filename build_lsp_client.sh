#!/bin/bash -e

source ./common.sh

pushd $(pwd) > /dev/null
cd ./${pack_folder}/YouCompleteMe
printh "updating modules"
git submodule update --init --recursive
printh "building"
./install.py --all --verbose
popd

prints "deploying plugins directory"
set -x
rsync -pEr ./${pack_folder} ${user_pack_folder}
set +x
printh "deployed"
ls ${user_pack_folder}
