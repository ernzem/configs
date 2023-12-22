#!/bin/bash

while getopts n:c:l: flag
do
    case "${flag}" in
        n) name=${OPTARG};;
        c) command=${OPTARG};;
        l) layout=${OPTARG};;
    esac
done

width=${2:-90%}
height=${2:-90%}
session=$(tmux display-message -p -F "#{session_name}")
if [ "$(tmux display-message -p -F "#{session_name}")" = "popup" ];then
    # tmux kill-pane
    tmux detach
else
    tmux popup -d '#{pane_current_path}' -xC -yC -w$width -h$height -E "tmux attach -t popup || tmux new -s popup"
fi

