#!/bin/sh
if grep -qi Microsoft /proc/version; then
   export DONT_PROMPT_WSL_INSTALL=1
   export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
fi
