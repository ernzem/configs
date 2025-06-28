#!/usr/bin/env bash

# curl -s https://api.github.com/repos/wezterm/wezterm/releases/latest | grep '"browser_download_url":' | grep '.fedora39.x86_64.rpm"' |  grep -o 'https://[^"]*' | wget -i -

# Params: 1. owner/repos 2. regex of file to download
latest_release_url() {
    curl -s https://api.github.com/repos/$1/releases/latest | grep '"browser_download_url":' | grep $2 |  grep -o 'https://[^"]*'
}

# Params: 1. owner/repos 2. regex of file to download
download_latest_release() {
    #~ latest_release_url $1 $2 | wget -i -
    local url=$(latest_release_url $1 $2)
    echo "Downloading ${url} ..."
    echo "${url}"| wget -qi - -O $3
    echo "Completed"

}

# USAGE EXAMPLE:
#   download_latest_release "wezterm/wezterm" ".fedora39.x86_64.rpm\""
#   latest_release_url "wezterm/wezterm" ".fedora39.x86_64.rpm\""
