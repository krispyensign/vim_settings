#!/bin/bash -ex

cd ./plugins/YouCompleteMe
git submodule update --init --recursive
./install.py --rust-completer --go-completer --ts-completer