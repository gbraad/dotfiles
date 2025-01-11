#!/bin/sh

# clean workspace folder
rm -rf /workspaces/dotfiles
ln -s ~/.dotfiles /workspaces/dotfiles

cd ~

# install docker
sudo dnf install -y \
        moby-engine \
        containerd \
    && dnf clean all \
    && rm -rf /var/cache/yum

exit 0