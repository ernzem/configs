#!/bin/bash

# Exit if any command fails
set -e

GET_RELEASE_SCRIPT_PATH="${HOME}/.cfg/scripts/github-get-latest-release.sh"
if [ ! -e ${GET_RELEASE_SCRIPT_PATH} ]; then
    echo "ERROR: script \"${GET_RELEASE_SCRIPT_PATH}\" not found!"
    exit 1
fi

echo "File \"${GET_RELEASE_SCRIPT_PATH}\" exists!"

#~ Imports functions for downloading latest release or retrieving latest release url
source $GET_RELEASE_SCRIPT_PATH 

#~ latest_release_url "wezterm/wezterm" ".fedora39.x86_64.rpm\""
u=$(latest_release_url "wezterm/wezterm" ".fedora39.x86_64.rpm\"")
echo "${u}"
#~ latest_release_url "hardpixel/unite-shell" "unite.*\.zip\""
#~ download_latest_release "hardpixel/unite-shell" "unite.*\.zip\"" "${HOME}/tmp/unite.zip"
#~ download_latest_release "hardpixel/unite-shell" "unite.*\.zip\""

#~ latest_release_url "neovim/neovim" ".*linux.*x86_64.appimage\""
#~ download_latest_release "neovim/neovim" ".*linux.*x86_64.appimage\""
printf "\nDONE\n"

