#!/bin/sh

# clean workspace folder
rm -rf /workspaces/dotfiles
ln -s ~/.dotfiles /workspaces/dotfiles

cd ~

. /etc/os-release
# we could do detection based on the lsb-release info to install more

exit 0