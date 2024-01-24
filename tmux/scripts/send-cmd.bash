#!/bin/bash

PANE_TITLE="__OUTPUT__"
PANE_INDEX=$(tmux list-panes -F '#{pane_index} #{pane_title}' | grep $PANE_TITLE | grep -o "^[0-9+]*")

#If tmux pane not created create one with title defined in PANE_TITLE
if ! [[ "$PANE_INDEX" =~ ^[0-9]+$ ]]; then
    tmux split-window -vf -p 30 -c "#{pane_current_path}"
    tmux select-pane -T "$PANE_TITLE"
fi

# Show terminal if hidden
tmux list-panes -F '#F' | grep -q Z
if [ $? -eq 0 ]; then
    tmux resize-pane -Z
fi

# Exit Copy Mode
tmux send-keys -t $PANE_INDEX C-c
# Send command
tmux send-keys -t $PANE_INDEX "$1" Enter
