#!/bin/bash -e

source ./common.sh

pushd $(pwd) > /dev/null
cd ./plugins/YouCompleteMe
printh "updating modules"
git submodule update --init --recursive
printh "building"
./install.py --all --verbose
popd

printh "deploying..."
set -x
chmod -R u+rw ${pack_folder}/YouCompleteMe
rsync -pEr ./${pack_folder} ${user_pack_folder}
ls -lah ${user_pack_folder}
