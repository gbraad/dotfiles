#!/bin/zsh

# tailscale helpers
alias ts='tailscale'
alias tsh='ts ssh'
alias tsip='ts ip -4'
alias tson=`ts status | grep -vh "offline"`

# tailproxy helpers
alias tp='tailproxy'
alias tph='tp ssh'
alias tpip='tp ip -4'
alias tpon=`tp status | grep -vh "offline"`

if [[ $(uname) == "Darwin" ]]; then
    alias tailscale='/Applications/Tailscale.app//Contents/MacOS/Tailscale'
fi

# tailproxy (user mode instance)
alias tailproxy=". ~/.local/bin/start-tailproxy"

# tailscale (user mode)
alias start-tailscale="screen -d -m tailscaled --tun='userspace-networking' --socket=/var/run/tailscale/tailscaled.sock"

# container
alias tailpod='podman run -d --name=tailscaled -v /var/lib:/var/lib -v /dev/net/tun:/dev/net/tun --network=host --cap-add=NET_ADMIN --cap-add=NET_RAW --env TS_AUTHKEY=$TAILSCALE_AUTHKEY tailscale/tailscale'
alias tailwings='podman run -d --name=tailwings --env TAILSCALE_AUTH_KEY=$TAILSCALE_AUTHKEY --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun ghcr.io/spotsnel/tailscale-tailwings:latest'

# ssh/scp over tailproxy
PROXYHOST="localhost:3215"
PROXYCMD="ProxyCommand /usr/bin/nc -x ${PROXYHOST} %h %p"
alias tpssh='ssh -o "${PROXYCMD}"'
alias tpscp='scp -o ""${PROXYCMD}"'
alias tpcurl='curl -x socks5h://${PROXYHOST}'
