#!/bin/zsh

generate_aliases() {
  local PREFIX=$1
  local NAME=$2
  local VERSION=$3
  local EXTRA_ARGS=$4

  local START_ARGS="\
    --systemd=always \
    --cap-add=NET_RAW \
    --cap-add=NET_ADMIN \
    --cap-add=SYS_ADMIN \
    --device=/dev/net/tun \
    --device=/dev/fuse \
  "

  alias ${PREFIX}env="podman run -it ${START_ARGS} --rm -v ${HOME}/Projects:/home/${USER}/Projects --entrypoint='' ghcr.io/gbraad-devenv/${NAME}/dotfiles:${VERSION} ${EXTRA_ARGS} zsh"
  alias ${PREFIX}sys="podman run -d --name=${PREFIX}sys --hostname ${HOSTNAME}-${PREFIX}sys ${START_ARGS} -v ${HOME}/Projects:/home/${USER}/Projects ghcr.io/gbraad-devenv/${NAME}/systemd:${VERSION} \
     && (mkdir -p ${HOME}/.config/systemd/user && cd ${HOME}/.config/systemd/user \
     && podman generate systemd --name --files ${PREFIX}sys) \
     && systemctl --user daemon-reload \
     && systemctl --user start container-${PREFIX}sys"
  alias ${PREFIX}root="podman exec -it ${PREFIX}sys /bin/zsh"
  alias ${PREFIX}user="podman exec -it ${PREFIX}sys su - gbraad"

  alias ${PREFIX}start="systemctl --user start container-${PREFIX}sys"
  alias ${PREFIX}stop="systemctl --user stop container-${PREFIX}sys"
    # && ${CONTAINER_RUNTIME} stop ${PREFIX}sys"
  alias ${PREFIX}exec="podman exec -it ${PREFIX}sys"
  alias ${PREFIX}sysctl="${PREFIX}exec systemctl"
  alias ${PREFIX}status="${PREFIX}sysctl status"
  alias ${PREFIX}tmux="${PREFIX}user -c 'tmux -2'"
}

FEDORA_VERSION="41"
generate_aliases "fed" "fedora" ${FEDORA_VERSION} ""
#generate_aliases "def" "fedora" ${FEDORA_VERSION} ""
generate_aliases "deb" "debian" "bookworm" ""
generate_aliases "alp" "alpine" "3.18" ""
generate_aliases "cen" "centos" "stream9" ""
generate_aliases "go" "ubi9-gotoolset" "1.22.7" ""
generate_aliases "ubi" "ubi" "9" ""
generate_aliases "ubu" "ubuntu" "jammy" ""
generate_aliases "alm" "almalinux" "9" ""
generate_aliases "sus" "opensuse" "15.5" ""
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
