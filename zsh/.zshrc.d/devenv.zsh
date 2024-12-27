#!/bin/zsh
CONTAINER_RUNTIME="${1:-podman}"

# Common function to generate aliases
generate_aliases() {
  local PREFIX=$1
  local NAME=$2
  local VERSION=$3
  local EXTRA_ARGS=$4

  # Combined capabilities and devices
  local START_ARGS="\
    --cap-add=NET_ADMIN \
    --cap-add=NET_RAW \
    --device=/dev/net/tun \
    --systemd=always \
    --cap-add=SYS_ADMIN \
    --device=/dev/fuse \
  "
  #--userns=keep-id:uid=$UID,gid=$GID \


  alias ${PREFIX}env="${CONTAINER_RUNTIME} run -it ${START_ARGS} --rm -v ${HOME}/Projects:/home/${USER}/Projects --entrypoint='' ghcr.io/gbraad-devenv/${NAME}/dotfiles:${VERSION} ${EXTRA_ARGS} bash"
  alias ${PREFIX}sys="${CONTAINER_RUNTIME} run -d --name=${PREFIX}sys --hostname ${HOSTNAME}-${PREFIX}sys ${START_ARGS} -v ${HOME}/Projects:/home/${USER}/Projects ghcr.io/gbraad-devenv/${NAME}/systemd:${VERSION} \
     && (mkdir -p ${HOME}/.config/systemd/user && cd ${HOME}/.config/systemd/user && ${CONTAINER_RUNTIME} generate systemd --name --files ${PREFIX}sys) && systemctl --user start container-${PREFIX}sys"
  alias ${PREFIX}root="${CONTAINER_RUNTIME} exec -it ${PREFIX}sys /bin/zsh"
  alias ${PREFIX}user="${CONTAINER_RUNTIME} exec -it ${PREFIX}sys su - gbraad"

  generate_control_aliases "${PREFIX}"
}

# Function to generate common control aliases
generate_control_aliases() {
  local PREFIX=$1
  alias ${PREFIX}start="systemctl --user start container-${PREFIX}sys"
  alias ${PREFIX}stop="systemctl --user stop container-${PREFIX}sys && ${CONTAINER_RUNTIME} stop ${PREFIX}sys"
  alias ${PREFIX}exec="${CONTAINER_RUNTIME} exec -it ${PREFIX}sys"
  alias ${PREFIX}sysctl="${PREFIX}exec systemctl"
  alias ${PREFIX}status="${PREFIX}sysctl status"
  alias ${PREFIX}tmux="${PREFIX}user -c 'tmux -2'"
}

# Fedora devenv
FEDORA_VERSION="41"
#generate_aliases "def" "fedora" ${FEDORA_VERSION} ""
generate_aliases "fed" "fedora" ${FEDORA_VERSION} ""

# Debian devenv
generate_aliases "deb" "debian" "bookworm" ""

# Alpine devenv
generate_aliases "alp" "alpine" "3.18" ""

# CentOS devenv
generate_aliases "cen" "centos" "stream9" ""

# UBI9 Go toolset devenv
generate_aliases "go" "ubi9-gotoolset" "1.22.7" ""

# UBI devenv
generate_aliases "ubi" "ubi" "9" ""

# Ubuntu devenv
generate_aliases "ubu" "ubuntu" "jammy" ""

# AlmaLinux devenv
generate_aliases "alm" "almalinux" "9" ""

# OpenSUSE devenv
generate_aliases "sus" "opensuse" "15.5" ""

# Tumbleweed devenv
generate_aliases "tum" "tumbleweed" "latest" ""

# Base on host distro
source /etc/os-release

case "$ID" in
    "fedora" | "bazzite")
        alias devenv="fedenv"
        alias devsysctl="fedsysctl"
        alias devstatus="fedstatus"
        alias devstart="fedstart"
        alias devstop="fedstop"
        alias devexec="fedexec"
        alias devsys="fedsys"
        alias devroot="fedroot"
        alias devuser="feduser"
        alias devtmux="fedtmux"
        alias devdesk="feddesk"
        ;;
    "debian" | "ubuntu")
        alias devenv="debenv"
        alias devsysctl="debsysctl"
        alias devstatus="debstatus"
        alias devstart="debstart"
        alias devstop="debstop"
        alias devexec="debexec"
        alias devsys="debsys"
        alias devroot="debroot"
        alias devuser="debuser"
        alias devtmux="debtmux"
        ;;
    *)
        alias devsys="defsys"
        alias devenv='echo "Unknown host distro; try \`defenv`\ or \`defdock\`"'
        ;;
esac
