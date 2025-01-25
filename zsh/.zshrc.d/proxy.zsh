#!/bin/zsh

CONFIG="${HOME}/.proxy"
alias proxyini="git config -f $CONFIG"

proxy() {
  if [ $# -lt 1 ]; then
    echo "Usage: $0 <prefix> [args...]"
    return 1
  fi

  local PREFIX=$1
  local SERVER=$(proxyini --get servers.${PREFIX})

  export http_proxy=${SERVER}
  export https_proxy=${SERVER}

  set | grep -E "http_proxy|https_proxy"
}

if [[ $(proxyini --get "proxy.aliases") == true ]]; then
  alias p="proxy"
fi
