#!/bin/zsh
if command -v tmux &> /dev/null && [ -n "$PS1" ] &&
    [[ ! "$TERM" =~ screen ]] &&
    [[ ! "$TERM" =~ tmux ]] &&
    [ -z "$TMUX" ]; then
#  { tmux attach -t shared ||
#    exec tmux new-session -s shared &&
#    exit; }
   { exec tmux new-session 'EDITOR=vim ranger ~' \; \
               rename-window 'ranger' &&
     exit;}
fi
