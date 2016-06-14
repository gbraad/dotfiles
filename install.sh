#!/bin/sh

# Crude multi-os installation option
if [ -x "/usr/bin/apt-get" ]
then
   apt-get install -y tmux zsh mc stow python-psutil
elif [ -x "/usr/bin/dnf" ]
then
   dnf install -y tmux zsh mc stow python-psutil
fi

# Add missing directory layout
cd ~
if [ ! -d "~/.config" ]
then
  mkdir .config
fi

mkdir -p .local/bin

# Personal dotfiles
git clone https://github.com/gbraad/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
git submodule init
git submodule update

# stow the configurations
stow powerline
stow zsh
stow tmux
stow vim
