#!/bin/bash
set -ex

username=$(whoami)

mkdir -p ~/.vim/pack/${username}/start/
mkdir -p ~/.vim/after
mkdir -p ~/.vim/autoload

rm -fr ~/.vim/pack/${username}/start/*

cp ~/.vimrc ~/.vimrc.bak
cp vimrc ~/.vimrc
cp -fr plugins/* ~/.vim/pack/${username}/start/
cp -fr after/* ~/.vim/after/
cp -fr autoload ~/.vim/autoload/

