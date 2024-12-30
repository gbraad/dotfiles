#!/bin/zsh

dev() {
  if [ $# -lt 2 ]; then
    echo "Usage: dev <prefix> <command> [args...]"
    return 1
  fi

  local PREFIX=$1
  local COMMAND=$2
  shift 2

  local START_SHELL="/bin/zsh"
  local START_ARGS=(
    "--systemd=always"
    "--cap-add=NET_RAW"
    "--cap-add=NET_ADMIN"
    "--cap-add=SYS_ADMIN"
    "--device=/dev/net/tun"
    "--device=/dev/fuse"
  )
  local START_PATHS=(
    "-v" "${HOME}/Projects:/home/${USER}/Projects"
  )

  case "$COMMAND" in
    "env")
      podman run --rm -it --hostname ${HOSTNAME}-${PREFIX}env --entrypoint='' \
        "${START_ARGS[@]}" "${START_PATHS[@]}" \
        $(generate_image_name $PREFIX "dotfiles") ${START_SHELL}
      ;;
    "sys")
      podman run -d --name=${PREFIX}sys --hostname ${HOSTNAME}-${PREFIX}sys \
        "${START_ARGS[@]}" "${START_PATHS[@]}" \
        $(generate_image_name $PREFIX "systemd")
        # TODO: systemd only when able to check for running state
        #&& (mkdir -p ${HOME}/.config/systemd/user && cd ${HOME}/.config/systemd/user \
        #&& podman generate systemd --name --files ${PREFIX}sys) \
        #&& systemctl --user daemon-reload \
        #&& systemctl --user start container-${PREFIX}sys
      ;;
    "root")
      podman exec -it ${PREFIX}sys ${START_SHELL}
      ;;
    "user")
      podman exec -it ${PREFIX}sys su - gbraad
      ;;
    "start")
      #systemctl --user start container-${PREFIX}sys
      podman start ${PREFIX}sys
      ;;
    "stop")
      #systemctl --user stop container-${PREFIX}sys
      podman stop ${PREFIX}sys
      ;;
    "exec")
      podman exec -it ${PREFIX}sys
      ;;
    "sysctl")
      dev ${PREFIX} exec systemctl
      ;;
    "status")
      dev ${PREFIX} sysctl status
      ;;
    "tmux")
      dev ${PREFIX} user -c 'tmux -2'
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

# legacy aliases

generate_aliases() {
  local PREFIX=$1
  alias ${PREFIX}env="dev ${PREFIX} env"
  alias ${PREFIX}sys="dev ${PREFIX} sys"
  alias ${PREFIX}root="dev ${PREFIX} root"
  alias ${PREFIX}user="dev ${PREFIX} user"
  alias ${PREFIX}tmux="dev ${PREFIX} tmux"
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
        alias devsys="fedsys"
        alias devroot="fedroot"
        alias devuser="feduser"
        alias devtmux="fedtmux"
        ;;
    "debian" | "ubuntu")
        alias devenv="debenv"
        alias devsys="debsys"
        alias devroot="debroot"
        alias devuser="debuser"
        alias devtmux="debtmux"
        ;;
    *)
        alias devsys="defsys"
        ;;
esac
