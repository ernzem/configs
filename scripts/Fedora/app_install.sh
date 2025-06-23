#!/bin/bash

# Exit if any command fails
set -e

sudo dnf install -y wl-clipboard
sudo dnf install -y timeshift
sudo dnf install -y wget
sudo dnf install -y gpg
sudo dnf install -y git
sudo dnf install -y curl
sudo dnf install -y fd-find
sudo dnf install -y gnupg
sudo dnf install -y ripgrep
sudo dnf install -y pandoc
sudo dnf group install c-development # Nvim needs c compiler but i install c dev tools
# sudo dnf install -y zsh

# Bat
sudo dnf install -y bat
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

# Brave Browser:
curl -fsS https://dl.brave.com/install.sh | sh

# Starship https://starship.rs/guide/#%F0%9F%9A%80-installation
curl -sS https://starship.rs/install.sh | sh

 # Flathub
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# FZF installation
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# NVIM
mkdir -p ~/.local/bin
curl -L -o ~/.local/bin/nvim https://github.com/neovim/neovim/releases/download/v0.11.2/nvim-linux-x86_64.appimage
chmod u+x ~/.local/bin/nvim

# Wezterm https://wezterm.org/install/linux.html
sudo dnf install -y https://github.com/wezterm/wezterm/releases/download/20240203-110809-5046fc22/wezterm-20240203_110809_5046fc22-1.fedora39.x86_64.rpm

echo ""
echo "DONE!"
