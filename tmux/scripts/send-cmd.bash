#!/bin/bash

PANE_TITLE="__OUTPUT__"
PANE_INDEX=$(tmux list-panes -F '#{pane_index} #{pane_title}' | grep $PANE_TITLE | grep -o "^[0-9+]*")

if ! [[ "$PANE_INDEX" =~ ^[0-9]+$ ]]; then
    tmux split-window -vf -p 30 -c "#{pane_current_path}"
    tmux select-pane -T "$PANE_TITLE"
fi

tmux send-keys -t $PANE_INDEX "$1" Enter
