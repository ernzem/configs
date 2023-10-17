#!/bin/bash

if [[ $(tmux display-message -p '#{window_panes}') == 1 ]]; then
    tmux split-window -vf -p 30 -c "#{pane_current_path}"
    # echo "SINGLE PANE"
    exit 0
fi

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
