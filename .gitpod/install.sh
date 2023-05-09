#!/bin/sh

rm -rf ~/.dotfiles
mv /workspace/dotfiles ~/.dotfiles
rm -rf /workspace/dotfiles
ln -s ~/.dotfiles /workspace/dotfiles
cd ~/.dotfiles

git fetch --unshallow
git submodule update --init --progress

rm -f ~/.zshrc
stow -R zsh

exit 0