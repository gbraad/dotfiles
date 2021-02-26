#!/bin/sh

# prevent VScode startup message
export DONT_PROMPT_WSL_INSTALL=1

export REMOTEHOST=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}')
# Allow remote X display
export DISPLAY=${REMOTEHOST}:0.0
# Allow remote audio
export PULSE_SERVER=tcp:${REMOTEHOST}

# force to home directory!
#cd ~
