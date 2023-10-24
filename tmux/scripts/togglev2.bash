#!/bin/bash

while getopts n:c:l: flag
do
    case "${flag}" in
        n) name=${OPTARG};;
        c) command=${OPTARG};;
        l) layout=${OPTARG};;
    esac
done

session=$(tmux display-message -p -F "#{session_name}")
# if [[ $(tmux display-message -p '#{window_panes}') == 1 ]]; then
    # tmux split-window -vf -p 30 -c "#{pane_current_path}"
    # exit 0
# fi

# tmux list-panes -F '#F' | grep -q Z
# if [ $? -eq 0 ]; then
    # tmux resize-pane -Z
    # tmux select-pane -l
# else
    # tmux select-pane -t 0
    # tmux resize-pane -Z
# fi

width=${2:-90%}
height=${2:-90%}
if [ "$(tmux display-message -p -F "#{session_name}")" = "popup" ];then
    tmux detach-client
else
    tmux popup -d '#{pane_current_path}' -xC -yC -w$width -h$height -E "tmux attach -t popup || tmux new -s popup"
fi
