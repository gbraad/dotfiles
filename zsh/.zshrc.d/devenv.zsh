#!/bin/zsh

dev() {
  if [ $# -lt 2 ]; then
    echo "Usage: dev <prefix> <command> [args...]"
    return 1
  fi

  local PREFIX=$1
  local COMMAND=$2
  shift 2

  case "$COMMAND" in
    "env" )
      echo $(generate_image_name $PREFIX "dotfiles")
      ;;
    "sys")
      echo $(generate_image_name $PREFIX "systemd")
      ;;
    "root")
      ;;
    "user")
      ;;
    "start")
      ;;
    "stop")
      ;;
    "exec")
      ;;
    "sysctl")
      ;;
    "status")
      ;;
    "tmux")
      ;;
    *)
      echo "Unknown command: dev $PREFIX $COMMAND"
      ;;
  esac
}


generate_image_name() {
  local PREFIX=$1
  local TYPE=$2
  local NAME=""
  local VERSION=""

  case "$PREFIX" in
    "fed" )
      NAME="fedora"
      VERSION="41"
      ;;
    "deb" )
      NAME="debian"
      VERSION="bookworm"
      ;;
    "alp" )
      NAME="alpine"
      VERSION="3.18"
      ;;
    "cen" )
      NAME="centos"
      VERSION="stream9"
      ;;
    "go" )
      NAME="ubi9-gotoolset"
      VERSION="1.22.7"
      ;;
    "ubi" )
      NAME="ubi"
      VERSION="9"
      ;;
    "ubu" )
      NAME="ubuntu"
      VERSION="jammy"
      ;;
    "alm" )
      NAME="almalinux"
      VERSION="9"
      ;;
    "sus" )
      NAME="opensuse"
      VERSION="15.5"
      ;;
    "tum" )
      NAME="tumbleweed"
      VERSION="latest"
      ;;
    *)
      echo "Unknown distro: $PREFIX"
      exit 1
      ;;
  esac

  echo "ghcr.io/gbraad-devenv/${NAME}/${TYPE}:${VERSION}"
}

generate_aliases() {
  local PREFIX=$1
  local START_SHELL="/bin/zsh"

  local START_ARGS="\
    --systemd=always \
    --cap-add=NET_RAW \
    --cap-add=NET_ADMIN \
    --cap-add=SYS_ADMIN \
    --device=/dev/net/tun \
    --device=/dev/fuse \
  "
  local START_PATHS="\
    -v ${HOME}/Projects:/home/${USER}/Projects \
  "

  alias ${PREFIX}env="podman run --rm -it --hostname ${HOSTNAME}-${PREFIX}env ${START_ARGS} --entrypoint='' ${START_PATHS} $(generate_image_name $PREFIX "dotfiles") ${START_SHELL}"
  alias ${PREFIX}sys="podman run -d --name=${PREFIX}sys --hostname ${HOSTNAME}-${PREFIX}sys ${START_ARGS} ${START_PATHS} $(generate_image_name $PREFIX "systemd") \
     && (mkdir -p ${HOME}/.config/systemd/user && cd ${HOME}/.config/systemd/user \
     && podman generate systemd --name --files ${PREFIX}sys) \
     && systemctl --user daemon-reload \
     && systemctl --user start container-${PREFIX}sys"

  alias ${PREFIX}start="systemctl --user start container-${PREFIX}sys"
  alias ${PREFIX}stop="systemctl --user stop container-${PREFIX}sys"
    # && ${CONTAINER_RUNTIME} stop ${PREFIX}sys"

  alias ${PREFIX}root="podman exec -it ${PREFIX}sys ${START_SHELL}"
  alias ${PREFIX}user="podman exec -it ${PREFIX}sys su - gbraad"
  alias ${PREFIX}exec="podman exec -it ${PREFIX}sys"
  alias ${PREFIX}sysctl="${PREFIX}exec systemctl"
  alias ${PREFIX}status="${PREFIX}sysctl status"
  alias ${PREFIX}tmux="${PREFIX}user -c 'tmux -2'"
}

generate_aliases "fed"
generate_aliases "deb"
generate_aliases "alp"
generate_aliases "cen"
generate_aliases "go"
generate_aliases "ubi"
generate_aliases "ubu"
generate_aliases "alm"
generate_aliases "sus"
generate_aliases "tum"

# Base on host distro
source /etc/os-release
case "$ID" in
    "fedora" | "bazzite")
        #alias devenv="fedenv"
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
        ;;
esac
