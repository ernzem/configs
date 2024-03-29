#!/bin/bash

PANE_TITLE="__OUTPUT__"
if [[ $(tmux display-message -p '#{window_panes}') == 1 ]]; then
    tmux split-window -vf -p 30 -c "#{pane_current_path}"
    tmux select-pane -T "$PANE_TITLE"
    exit 0
fi

tmux list-panes -F '#F' | grep -q Z
if [ $? -eq 0 ]; then
    tmux resize-pane -Z
    tmux select-pane -l
else
    tmux select-pane -t 0
    tmux resize-pane -Z
fi
