#!/bin/zsh
# check if powerline-local
if [[ -r ~/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
    source ~/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
# else use distro installed powerline
elif [[ -f `which powerline-daemon` ]]; then
    powerline-daemon -q
    POWERLINE_ZSH_CONTINUATION=1
    POWERLINE_ZSH_SELECT=1
    . /usr/share/powerline/zsh/powerline.zsh
fi

