 #!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find $REPOS -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

# selected_name=$(basename "$selected" | tr . _)
# wezterm_running=$(ps aux | grep WezTerm)
# if [[ -z $wezterm_running ]]; then
#     exit 0
# fi

tab_id=$(wezterm cli list --format json | jq ".[] | select(.cwd == \"file://$selected\")| .tab_id")
if [[ -n $tab_id ]]; then
    wezterm cli activate-tab --tab-id $tab_id
    exit 0
fi

pane_id=$(wezterm cli spawn --cwd $selected)
# wezterm cli set-tab-title --pane-id $pane_id $selected_name
