#!/bin/bash -e

source ./common.sh

check_command python
check_command pip
check_command go
check_command javac
check_command cmake
check_command node
check_command npm
check_command rustup

pushd $(pwd) > /dev/null
cd ./${pack_folder}YouCompleteMe
printh "updating modules"
git submodule update --init --recursive
printh "building"
./install.py --all --verbose
printh "correcting permissions"
chmod -R u+rw *
popd

prints "deploying plugins directory"
set -x
rsync -Elpr ./${pack_folder} ${user_pack_folder}
set +x
printh "deployed"
ls ${user_pack_folder}
