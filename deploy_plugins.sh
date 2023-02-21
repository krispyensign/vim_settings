#!/bin/bash -e

source common.sh

printh "deploying plugins directory"
cmd="rsync -Elpr --info=progress2 --stats --no-i-r ./${pack_folder} ${user_pack_folder}"
prints "running: ${cmd}" 
bluey
${cmd}
printh "deployed"
ls ${user_pack_folder}
