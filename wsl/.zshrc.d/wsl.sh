#!/bin/sh
export DONT_PROMPT_WSL_INSTALL=1
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0

# force to home directory!
cd ~
