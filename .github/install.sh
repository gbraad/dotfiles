#!/bin/sh

# clean workspace folder
rm -rf /workspaces/upstream
ln -s ~/.dotfiles /workspaces/upstream

rm -rf /workspaces/dotfiles
ln -s ~/.dotfiles /workspaces/dotfiles

rm -rf /workspaces/dotfiles-downstream
ln -s ~/.dotfiles /workspaces/dotfiles-downstream


cd ~

. /etc/os-release
# we could do detection based on the lsb-release info to install more

exit 0