#!/bin/zsh
CONTAINER_RUNTIME="${1:-podman}"


# --- Fedora devenv --- https://github.com/gbraad-devenv/fedora
FEDORA_VERSION="38"

# dotfiles
alias defenv='${CONTAINER_RUNTIME} run -it --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun --rm -v $HOME/Projects:/home/${USER}/Projects ghcr.io/gbraad-devenv/fedora/dotfiles:${FEDORA_VERSION} /bin/zsh'

# systemd
alias defsys='podman run -d --name=devsys --hostname $HOSTNAME-devsys --systemd=always --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun -v $HOME/Projects:/home/${USER}/Projects ghcr.io/gbraad-devenv/fedora/systemd:${FEDORA_VERSION} '
alias defdock='docker run -d --name=devsys --hostname $HOSTNAME-devsys --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun -v $HOME/Projects:/home/${USER}/Projects --entrypoint="" ghcr.io/gbraad-devenv/fedora/dotfiles:${FEDORA_VERSION}  sleep infinity'
alias defroot='${CONTAINER_RUNTIME} exec -it devsys /bin/zsh'
alias defuser='${CONTAINER_RUNTIME} exec -it devsys su - gbraad'


# --- Debian devenv --- https://github.com/gbraad-devenv/debian/
DEBIAN_VERSION="bullseye"

# dotfiles
alias debenv='${CONTAINER_RUNTIME} run -it --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun --rm -v $HOME/Projects:/home/${USER}/Projects --entrypoint="" ghcr.io/gbraad-devenv/debian/dotfiles:${DEBIAN_VERSION} /bin/zsh'

# systemd
alias debsys='podman run -d --name=debsys --hostname $HOSTNAME-debsys --systemd=always --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun -v $HOME/Projects:/home/${USER}/Projects ghcr.io/gbraad-devenv/debian/systemd:${DEBIAN_VERSION}'
alias debroot='${CONTAINER_RUNTIME} exec -it debsys /bin/zsh'
alias debuser='${CONTAINER_RUNTIME} exec -it debsys su - gbraad'


# --- base on host distro

source /etc/os-release

if [ "$ID" = "fedora" ]
then
    alias devenv=defenv
    alias devsys=defsys
    alias devroot=defroot
    alias devuser=defuser
elif [ "$ID" = "debian" ]
then
    alias devenv=debenv
    alias devsys=debsys
    alias devroot=debroot
    alias devuser=debuser
fi

