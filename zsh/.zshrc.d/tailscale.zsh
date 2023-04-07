#!/bin/zsh
# tailscale
alias ts='tailscale'
alias tsh='tailscale ssh'
if [[ $(uname) == "Darwin" ]]; then
    alias tailscale='/Applications/Tailscale.app//Contents/MacOS/Tailscale'
fi
alias tailproxy=". ~/.local/bin/start-tailproxy"