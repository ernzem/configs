#!/usr/bin/env bash

# curl -s https://api.github.com/repos/wezterm/wezterm/releases/latest | grep '"browser_download_url":' | grep '.fedora39.x86_64.rpm"' |  grep -o 'https://[^"]*' | wget -i -

# Params: 1. owner/repos 2. regex of file to download
get_url() {
    curl -s https://api.github.com/repos/$1/releases/latest | grep '"browser_download_url":' | grep $2 |  grep -o 'https://[^"]*'
}

# Params: 1. owner/repos 2. regex of file to download
download() {
    get_url $1 $2 | wget -i -
}

# USAGE EXAMPLE:
#   download "wezterm/wezterm" ".fedora39.x86_64.rpm\""
