#!/bin/sh
# check if powerline-local
if [[ -r ~/.local/lib/python3.12/site-packages/powerline/bindings/bash/powerline.sh ]]; then
    #powerline-daemon -q
    POWERLINE_BASH_CONTINUATION=1
    POWERLINE_BASH_SELECT=1

    source ~/.local/lib/python3.12/site-packages/powerline/bindings/bash/powerline.sh
fi

