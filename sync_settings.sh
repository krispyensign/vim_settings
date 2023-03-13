#!/bin/bash -e

source ./common.sh

# deploy other addons
printh "deploying other addons"
cp -fr after/ ${vim_dir}/after/

# deploy the new vimrc file
printh "deploying vimrc"
touch ${HOME}/.vimrc
cp ${HOME}/.vimrc ${HOME}/.vimrc.bak
cp vimrc ${HOME}/.vimrc

printh "Done! Use <leader>RR to load new settings without restarting vim :)"