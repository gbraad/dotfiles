#!/bin/zsh
CONTAINER_RUNTIME="${1:-podman}"


# --- Fedora devenv --- https://github.com/gbraad-devenv/fedora
FEDORA_VERSION="41"

# dotfiles
alias defenv='${CONTAINER_RUNTIME} run -it --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun --rm -v $HOME/Projects:/home/${USER}/Projects --entrypoint="" ghcr.io/gbraad-devenv/fedora/dotfiles:${FEDORA_VERSION} /bin/zsh'

# rdesktop (testing)
alias defdesk='${CONTAINER_RUNTIME} run -d --name defdesk -v $HOME/Projects:/home/${USER}/Projects ghcr.io/gbraad-devenv/fedora/rdesktop:${FEDORA_VERSION}'

# systemd
alias defsys='podman run -d --name=devsys --hostname $HOSTNAME-devsys --systemd=always --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun -v $HOME/Projects:/home/${USER}/Projects ghcr.io/gbraad-devenv/fedora/systemd:${FEDORA_VERSION} && (mkdir -p $HOME/.config/systemd/user && cd $HOME/.config/systemd/user && podman generate systemd --name --files devsys)'
alias defstart='systemctl --user start container-devsys'
alias defstop='systemctl --user stop container-devsys'
alias defexec='${CONTAINER_RUNTIME} exec -it devsys'
alias defsysctl='defexec systemctl'
alias defstatus='defsysctl status'
alias defroot='defexec /bin/zsh'
alias defuser='defexec su - gbraad'
alias deftmux='defuser -c "tmux -2"'

alias defdock='docker run -d --name=devsys --hostname $HOSTNAME-devsys --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun -v $HOME/Projects:/home/${USER}/Projects --entrypoint="" ghcr.io/gbraad-devenv/fedora/dotfiles:${FEDORA_VERSION}  sleep infinity'


# --- Debian devenv --- https://github.com/gbraad-devenv/debian/
DEBIAN_VERSION="bookworm"

# dotfiles
alias debenv='${CONTAINER_RUNTIME} run -it --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun --rm -v $HOME/Projects:/home/${USER}/Projects --entrypoint="" ghcr.io/gbraad-devenv/debian/dotfiles:${DEBIAN_VERSION} /bin/zsh'

# systemd
alias debsys='podman run -d --name=debsys --hostname $HOSTNAME-debsys --systemd=always --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun -v $HOME/Projects:/home/${USER}/Projects ghcr.io/gbraad-devenv/debian/systemd:${DEBIAN_VERSION} && (mkdir -p $HOME/.config/systemd/user && cd $HOME/.config/systemd/user && podman generate systemd --name --files debsys)'
alias debstart='systemctl --user start container-debsys'
alias debstop='systemctl --user stop container-debsys'
alias debexec='${CONTAINER_RUNTIME} exec -it debsys'
alias debsysctl='debexec systemctl'
alias debstatus='debsysctl status'
alias debroot='debexec /bin/zsh'
alias debuser='debexec su - gbraad'
alias debtmux='debuser -c "tmux -2"'


# --- Alpine devenv --- https://github.com/gbraad-devenv/alpine/
ALPINE_VERSION="3.18"

# dotfiles
alias alpenv='${CONTAINER_RUNTIME} run -it --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun --rm -v $HOME/Projects:/home/${USER}/Projects --entrypoint="" ghcr.io/gbraad-devenv/alpine/dotfiles:${ALPINE_VERSION} /bin/zsh'

# system (init)
alias alpsys='podman run -d --name=alpsys --hostname $HOSTNAME-alpsys --systemd=always --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun -v $HOME/Projects:/home/${USER}/Projects ghcr.io/gbraad-devenv/alpine/system:${ALPINE_VERSION}'
alias alproot='${CONTAINER_RUNTIME} exec -it alpsys /bin/zsh'
alias alpuser='${CONTAINER_RUNTIME} exec -it alpsys su - gbraad'


# --- CentOS devenv --- https://github.com/gbraad-devenv/centos/
CENTOS_VERSION="stream9"

# dotfiles
alias cenenv='${CONTAINER_RUNTIME} run -it --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun --rm -v $HOME/Projects:/home/${USER}/Projects --entrypoint="" ghcr.io/gbraad-devenv/centos/dotfiles:${CENTOS_VERSION} /bin/zsh'

# systemd
alias censys='podman run -d --name=censys --hostname $HOSTNAME-censys --systemd=always --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun -v $HOME/Projects:/home/${USER}/Projects ghcr.io/gbraad-devenv/centos/systemd:${CENTOS_VERSION}'
alias cenroot='${CONTAINER_RUNTIME} exec -it censys /bin/zsh'
alias cenuser='${CONTAINER_RUNTIME} exec -it censys su - gbraad'


# --- UBI8 Go toolset devenv --- https://github.com/gbraad-devenv/ubi8-gotoolset/
GO_VERSION="1.20"

# dotfiles
alias goenv='${CONTAINER_RUNTIME} run -it --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun --rm -v $HOME/Projects:/home/${USER}/Projects --userns=keep-id:uid=$UID,gid=$GID --entrypoint="" ghcr.io/gbraad-devenv/ubi8-gotoolset/dotfiles:${GO_VERSION} /bin/zsh'

# systemd
alias gosys='podman run -d --name=gosys --hostname $HOSTNAME-gosys --systemd=always --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun -v $HOME/Projects:/home/${USER}/Projects --userns=keep-id:uid=$UID,gid=$GID ghcr.io/gbraad-devenv/ubi8-gotoolset/systemd:${GO_VERSION}'
alias goroot='${CONTAINER_RUNTIME} exec -it gosys /bin/zsh'
alias gouser='${CONTAINER_RUNTIME} exec -it gosys su - gbraad'


# --- UBI devenv --- https://github.com/gbraad-devenv/ubi/
UBI_VERSION="9"

# dotfiles
alias ubienv='${CONTAINER_RUNTIME} run -it --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun --rm -v $HOME/Projects:/home/${USER}/Projects --entrypoint="" ghcr.io/gbraad-devenv/ubi/dotfiles:${UBI_VERSION} /bin/zsh'

# systemd
alias ubisys='podman run -d --name=ubisys --hostname $HOSTNAME-ubisys --systemd=always --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun -v $HOME/Projects:/home/${USER}/Projects ghcr.io/gbraad-devenv/ubi/systemd:${UBI_VERSION}'
alias ubiroot='${CONTAINER_RUNTIME} exec -it ubisys /bin/zsh'
alias ubiuser='${CONTAINER_RUNTIME} exec -it ubisys su - gbraad'


# --- Ubuntu devenv --- https://github.com/gbraad-devenv/ubuntu/
UBUNTU_VERSION="jammy"

# dotfiles
alias ubuenv='${CONTAINER_RUNTIME} run -it --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun --rm -v $HOME/Projects:/home/${USER}/Projects --entrypoint="" ghcr.io/gbraad-devenv/ubuntu/dotfiles:${UBUNTU_VERSION} /bin/zsh'

# systemd
alias ubusys='podman run -d --name=ubusys --hostname $HOSTNAME-ubusys --systemd=always --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun -v $HOME/Projects:/home/${USER}/Projects ghcr.io/gbraad-devenv/ubuntu/systemd:${UBUNTU_VERSION}'
alias uburoot='${CONTAINER_RUNTIME} exec -it ubusys /bin/zsh'
alias ubuuser='${CONTAINER_RUNTIME} exec -it ubusys su - gbraad'


# --- AlmaLinux devenv --- https://github.com/gbraad-devenv/almalinux/
ALMALINUX_VERSION="9"

# dotfiles
alias almenv='${CONTAINER_RUNTIME} run -it --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun --rm -v $HOME/Projects:/home/${USER}/Projects --entrypoint="" ghcr.io/gbraad-devenv/almalinux/dotfiles:${ALMALINUX_VERSION} /bin/zsh'

# systemd
alias almsys='podman run -d --name=almsys --hostname $HOSTNAME-almsys --systemd=always --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun -v $HOME/Projects:/home/${USER}/Projects ghcr.io/gbraad-devenv/almalinux/systemd:${ALMALINUX_VERSION}'
alias almroot='${CONTAINER_RUNTIME} exec -it almsys /bin/zsh'
alias almuser='${CONTAINER_RUNTIME} exec -it almsys su - gbraad'


# --- OpenSUSE devenv --- https://github.com/gbraad-devenv/opensuse/
OPENSUSE_VERSION="15.5"

# dotfiles
alias susenv='${CONTAINER_RUNTIME} run -it --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun --rm -v $HOME/Projects:/home/${USER}/Projects --entrypoint="" ghcr.io/gbraad-devenv/opensuse/dotfiles:${OPENSUSE_VERSION} /bin/zsh'

# systemd
alias sussys='podman run -d --name=sussys --hostname $HOSTNAME-sussys --systemd=always --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun -v $HOME/Projects:/home/${USER}/Projects ghcr.io/gbraad-devenv/opensuse/systemd:${OPENSUSE_VERSION}'
alias susroot='${CONTAINER_RUNTIME} exec -it sussys /bin/zsh'
alias sususer='${CONTAINER_RUNTIME} exec -it sussys su - gbraad'


# --- Tumbleweed devenv --- https://github.com/gbraad-devenv/tumbleweed/
TUMBLEWEED_VERSION="latest"

# dotfiles
alias tumenv='${CONTAINER_RUNTIME} run -it --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun --rm -v $HOME/Projects:/home/${USER}/Projects --entrypoint="" ghcr.io/gbraad-devenv/tumbleweed/dotfiles:${TUMBLEWEED_VERSION} /bin/zsh'

# systemd
alias tumsys='podman run -d --name=tumsys --hostname $HOSTNAME-tumsys --systemd=always --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun -v $HOME/Projects:/home/${USER}/Projects ghcr.io/gbraad-devenv/tumbleweed/systemd:${TUMBLEWEED_VERSION}'
alias tumroot='${CONTAINER_RUNTIME} exec -it tumsys /bin/zsh'
alias tumuser='${CONTAINER_RUNTIME} exec -it tumsys su - gbraad'


# --- base on host distro
source /etc/os-release

if [ "$ID" = "fedora" ]
then
    alias devenv=defenv
    alias devsysctl=defsysctl
    alias devstatus=defstatus
    alias devstart=defstart
    alias devstop=defstop
    alias devexec=defexec
    alias devsys=defsys
    alias devroot=defroot
    alias devuser=defuser
    alias devtmux=deftmux
    alias devdesk=defdesk
elif [ "$ID" = "debian" ]
then
    alias devenv=debenv
    alias devsysctl=debsysctl
    alias devstatus=debstatus
    alias devstart=debstart
    alias devstop=debstop
    alias devexec=debexec
    alias devsys=debsys
    alias devroot=debroot
    alias devuser=debuser
    alias devtmux=debtmux
fi
