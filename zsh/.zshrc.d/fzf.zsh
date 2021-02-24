#!/bin/zsh

if [[ -r /usr/share/fzf/shell/key-bindings.zsh ]]; then
    source /usr/share/fzf/shell/key-bindings.zsh
    # since package is b0rked?
    source /usr/share/zsh/site-functions/fzf
fi
