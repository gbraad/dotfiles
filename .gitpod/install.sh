#!/bin/sh

rm -rf ~/.dotfiles
ln -s /workspace/dotfiles ~/.dotfiles
cd ~/.dotfiles
git submodule update --init --progress

exit 0