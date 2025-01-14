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
