#!/bin/zsh

podsysctl() {

   if [ $# -lt 2 ]; then
       echo "Usage: podsysctl <name> <command> [args ...]"
       return 1
   fi

   name=$1
   shift 1
   podman exec -it ${name} systemctl $@

}

tailsysctl() {

   if [ $# -lt 2 ]; then
       echo "Usage: tailsysctl <name> <command> [args ...]"
       return 1
   fi

   name=$1
   shift 1
   tailscale ssh ${USER}@${name} systemctl $@

}

