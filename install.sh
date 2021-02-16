#!/bin/sh
APTPKGS="git zsh stow"
RPMPKGS="git-core zsh stow"

# Crude multi-os installation option
if [ -x "/usr/bin/apt-get" ]
then
   sudo apt-get install -y $APTPKGS
elif [ -x "/usr/bin/dnf" ]
then
   sudo dnf install -y $RPMPKGS
elif [ -x "/usr/bin/yum" ]
then
   sudo yum install -y $RPMPKGS
fi

# Add missing directory layout
if [ ! -d "~/.config" ]
then
  mkdir -p ~/.config
fi

mkdir -p ~/.local/bin
mkdir -p ~/.local/lib/python2.7/site-packages/

# Personal dotfiles
git clone https://github.com/gbraad/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
git submodule update --init --progress

# stow the configurations
stow powerline
stow zsh
stow tmux
stow vim
stow git
