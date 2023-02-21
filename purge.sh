#!/bin/bash -e

source common.sh

# Get the username and plugins
printh "Resetting permissions..."
chmod -R 777 ${user_pack_folder}
printh "Purging plugins in home..."
rm -fr ${user_pack_folder}
printh "Purging plugins in project..."
rm -fr ${pack_folder}
printh "Done!"