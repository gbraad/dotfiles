#!/bin/zsh

CONFIG="${HOME}/.dot"
alias dotini="git config -f $CONFIG"

dot() {
  if [ $# -lt 1 ]; then
    echo "Usage: dev <prefix> <command> [args...]"
    return 1
  fi

  local COMMAND=$1

  case "$COMMAND" in
    "up")
      cd ~/.dotfiles
      git pull
      cd -
      ;;
    *)
      echo "Unknown command: dot $COMMAND"
      ;;
  esac
}

if [[ $(dotini --get "dotfiles.aliases") == true ]]; then
  alias dotup="dot up"
fi

if [[ $(dotini --get "dotfiles.autoupdate") == true ]]; then
  dot up
fi
