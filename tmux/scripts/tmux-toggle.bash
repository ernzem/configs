#!/bin/bash

tmux list-panes -F '#F' | grep -q Z
if [ $? -eq 0 ]; then
    # echo "Command succeeded"
    tmux resize-pane -Z
    tmux select-pane -l
else
    # echo "Command failed"
    tmux select-pane -t 0
    tmux resize-pane -Z
fi
