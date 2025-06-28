#!/bin/bash

# Exit if any command fails
set -e

# If sway minimal install, these are needed:
# sudo apt install -y zip unzip git lxpolkit libfuse2

# Others
# sudo apt update && sudo apt upgrade
sudo apt install -y build-essential
sudo apt install -y apt-transport-https 
sudo apt install -y wget 
sudo apt install -y gpg
sudo apt install -y git
sudo apt install -y curl
sudo apt install -y ca-certificates
sudo apt install -y gnupg
sudo apt install -y ripgrep
sudo apt install -y timeshift
sudo apt install -y pkexec
sudo apt install -y foot
sudo apt install -y pandoc
sudo apt install -y libpam-fprintd
sudo apt install -y dconf-editor
sudo apt install -y wl-clipboard
sudo apt install -y fd-find
sudo apt install -y libreoffice
sudo apt install -y celluloid

# sudo apt install -y zsh
# sudo apt install -y libnotify-bin # for sending notifications via cli
# sudo apt install -y xclip # X11 only
# sudo apt install -y gnome-tweaks
# -----------------------------------------------------------------------------------------------------------------------
sudo apt install -y bat
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat
# -----------------------------------------------------------------------------------------------------------------------
# Brave Browser https://brave.com/linux/#debian-ubuntu-mint
# curl -fsS https://dl.brave.com/install.sh | sh
# -----------------------------------------------------------------------------------------------------------------------
# Starship https://starship.rs/guide/#%F0%9F%9A%80-installation
curl -sS https://starship.rs/install.sh | sh
# echo 'eval "$(starship init bash
# -----------------------------------------------------------------------------------------------------------------------
# Flatpak & Flathub
# sudo apt install flatpak
# flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
# -----------------------------------------------------------------------------------------------------------------------
# fzf installation
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
# -----------------------------------------------------------------------------------------------------------------------
# VS Code
# wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
# sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
# sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
# rm -f packages.microsoft.gpg
# sudo apt update
# sudo apt install -y code
# -----------------------------------------------------------------------------------------------------------------------
# Typora
wget -qO - https://typora.io/linux/public-key.asc | sudo tee /etc/apt/trusted.gpg.d/typora.asc
sudo add-apt-repository 'deb https://typora.io/linux ./'
sudo apt update
sudo apt install -y typora
# -----------------------------------------------------------------------------------------------------------------------
# Syntching
# Add the release PGP keys:
# sudo curl -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg

# Add the "stable" channel to your APT sources:
# echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

# Add the "candidate" channel to your APT sources:
# echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing candidate" | sudo tee /etc/apt/sources.list.d/syncthing.list

# Update and install syncthing:
# sudo apt update
# sudo apt install -y syncthing

# -------------------------------------------------------------------------------------------------------------------------
# sudo apt install -y tmux
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

mkdir -p ~/.local/bin
curl -L -o ~/.local/bin/nvim https://github.com/neovim/neovim/releases/download/v0.11.0/nvim-linux-x86_64.appimage
chmod u+x ~/.local/bin/nvim

# ---------------------------------------------------------------------------------------------------------------------------
# Wezterm
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo apt update && sudo apt install -y wezterm
echo ""
echo "DONE!"


