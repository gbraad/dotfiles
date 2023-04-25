#!/bin/zsh

# tailscale
alias ts='tailscale'
alias tsh='ts ssh'
alias tsip='ts ip -4'
alias tp='tailproxy'
alias tph='tp ssh'
alias tpip='tp ip -4'

if [[ $(uname) == "Darwin" ]]; then
    alias tailscale='/Applications/Tailscale.app//Contents/MacOS/Tailscale'
fi

# tailproxy (user mode instance)
alias tailproxy=". ~/.local/bin/start-tailproxy"

# container
alias taildock='podman run -d --name=tailscaled -v /var/lib:/var/lib -v /dev/net/tun:/dev/net/tun --network=host --cap-add=NET_ADMIN --cap-add=NET_RAW --env TS_AUTHKEY=$TS_AUTHKEY tailscale/tailscale'
alias tailwings='podman run -d --name=tailwings --env TAILSCALE_AUTH_KEY=$TS_AUTHKEY --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun ghcr.io/spotsnel/tailscale-tailwings:latest'
