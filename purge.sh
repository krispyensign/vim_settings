#!/bin/bash -ex

source common.sh

# Get the username and plugins
printh "Resetting permissions"
chmod -Rv 777 ${user_pack_folder}
printh "Purging plugins in home"
rm -frv ${user_pack_folder}
printh "Purging plugins in project"
rm -frv ${pack_folder}
printh "Done!"