#!/bin/zsh
# use distro installed powerline
if [ -f `which powerline-daemon` ]; then
    powerline-daemon -q
    POWERLINE_ZSH_CONTINUATION=1
    POWERLINE_ZSH_SELECT=1
    . /usr/share/powerline/zsh/powerline.zsh
# else check if powerline-local
elif [[ -r ~/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
    source ~/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
fi

