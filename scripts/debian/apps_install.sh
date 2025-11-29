#!/bin/bash

# Exit if any command fails
set -e

GET_RELEASE_SCRIPT_PATH="${HOME}/.cfg/scripts/github-get-latest-release.sh"

if [ ! -e ${GET_RELEASE_SCRIPT_PATH} ]; then
    echo "ERROR: script \"${GET_RELEASE_SCRIPT_PATH}\" not found!"
    exit 1
fi

#~ Imports functions for downloading latest release or retrieving latest release url
source $GET_RELEASE_SCRIPT_PATH

sudo apt install -y wl-clipboard
sudo apt install -y wget
sudo apt install -y git
sudo apt install -y curl
sudo apt install -y ripgrep
sudo apt install -y pandoc
sudo apt install -y podman
# sudo apt install -y keepassxc
sudo apt install -y fd-find
#~ sudo apt install -y geany geany-plugins-*
# sudo apt install -y gpg
# sudo apt install -y gnupg
# sudo apt install -y dconf-editor
# sudo apt install -y c-development # Nvim needs c compiler but i install c dev tools
# sudo apt install -y foot
# sudo apt install -y zsh
# sudo apt install -y alacritty

# Bat 
sudo apt install -y bat
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

# Brave Browser:
curl -fsS https://dl.brave.com/install.sh | sh

# Starship https://starship.rs/guide/#%F0%9F%9A%80-installation
curl -sS https://starship.rs/install.sh | sh

 # Flathub
 # Flatpak & Flathub
sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# FZF installation
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# NVIM
mkdir -p ~/.local/bin
download_latest_release "neovim/neovim" ".*linux.*x86_64.appimage\"" "${HOME}/.local/bin/nvim"
chmod u+x ~/.local/bin/nvim

# Wezterm https://wezterm.org/install/linux.html
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo apt update && sudo apt install -y wezterm

# VSCodium: https://vscodium.com/#install
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
echo -e 'Types: deb\nURIs: https://download.vscodium.com/debs\nSuites: vscodium\nComponents: main\nArchitectures: amd64 arm64\nSigned-by: /usr/share/keyrings/vscodium-archive-keyring.gpg' \
| sudo tee /etc/apt/sources.list.d/vscodium.sources
sudo apt update && sudo apt install -y codium


# VSCode: https://code.visualstudio.com/docs/setup/linux


# Sublime text:  https://www.sublimetext.com/docs/linux_repositories.html
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo tee /etc/apt/keyrings/sublimehq-pub.asc > /dev/null
echo -e 'Types: deb\nURIs: https://download.sublimetext.com/\nSuites: apt/stable/\nSigned-By: /etc/apt/keyrings/sublimehq-pub.asc' | sudo tee /etc/apt/sources.list.d/sublime-text.sources
sudo apt update
sudo apt install -y sublime-text

echo ""
echo "DONE!"
