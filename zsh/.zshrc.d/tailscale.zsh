#!/bin/zsh

# general helpers
alias offline_filter='grep -v "offline"'
alias direct_filter='grep "direct"'
alias exitnode_filter='grep "offers exit node"'

# tailscale helpers
alias ts='tailscale'
alias tss='ts status'
alias tsh='ts ssh'
alias tsip='ts ip -4'
alias tson='tss | offline_filter'
alias tsdir='tss | direct_filter'
alias tsexit='tss | exitnode_filter'

# tailproxy helpers
alias tp='tailproxy'
alias tps='tp status'
alias tph='tp ssh'
alias tpip='tp ip -4'
alias tpon='tps | offline_filter'
alias tpdir='tps | direct_filter'
alias tpexit='tps | exitnode_filter'

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
