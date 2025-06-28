#!/bin/bash

# Exit if any command fails
set -e

# If sway minimal install, these are needed:
sudo apt install -y zip unzip git lxpolkit libfuse2 build-essential

# Others
sudo apt update && sudo apt upgrade
sudo apt install -y apt-transport-https
sudo apt install -y wget gpg git curl ca-certificates gnupg
sudo apt install -y tmux
sudo apt install -y ripgrep
sudo apt install -y timeshift pkexec
# sudo apt install -y foot
sudo apt install -y pandoc
sudo apt install -y libpam-fprintd
sudo apt install -y zsh
sudo apt install -y dconf-editor
sudo apt install -y wl-clipboard # Wayland only
sudo apt install -y fd-find
# sudo apt install -y libnotify-bin # for sending notifications via cli
# sudo apt install -y xclip # X11 only
# sudo apt install -y gnome-tweaks
# -----------------------------------------------------------------------------------------------------------------------
sudo apt install -y bat
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat
# -----------------------------------------------------------------------------------------------------------------------
# Brave Browser https://brave.com/linux/#debian-ubuntu-mint
# sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
# echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
# sudo apt update && sudo apt install -y brave-browser
# -----------------------------------------------------------------------------------------------------------------------
# Starship https://starship.rs/guide/#%F0%9F%9A%80-installation
curl -sS https://starship.rs/install.sh | sh
# echo 'eval "$(starship init bash)"' >> ~/.bashrc
# -----------------------------------------------------------------------------------------------------------------------
# Flatpak & Flathub
sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
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
# Docker
# sudo apt update
# sudo apt-get install -y ca-certificates curl gnupg

# sudo install -m 0755 -d /etc/apt/keyrings
# curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
# sudo chmod a+r /etc/apt/keyrings/docker.gpg

# echo \
#   "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
#   "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
#  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# sudo apt update
# Docker CLI
# sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


# Make docker as non root user
# sudo groupadd docker
# sudo usermod -aG docker $USER

# Stop docker autostart docker
# sudo systemctl disable docker.service
# sudo systemctl disable containerd.service
# -----------------------------------------------------------------------------------------------------------------------
# Typora
# wget -qO - https://typora.io/linux/public-key.asc | sudo tee /etc/apt/trusted.gpg.d/typora.asc
# sudo add-apt-repository 'deb https://typora.io/linux ./'
# sudo apt update
# sudo apt install -y typora
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
# -----------------------------------------------------------------------------------------------------------------------
# Neovim setup
# TODO: install nvim AppImage.
# TODO: figure out how to deal with python health check
# sudo apt install -y python3-pip xclip
# python3 -m pip install --user --upgrade pynvim

# -------------------------------------------------------------------------------------------------------------------------
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

mkdir -p ~/.local/bin
curl -L -o ~/.local/bin/nvim https://github.com/neovim/neovim/releases/download/releases/latest/nvim-linux-x86_64.appimage
chmod u+x ~/.local/bin/nvim

# curl -LO https://github.com/wez/wezterm/releases/download/20240128-202157-1e552d76/wezterm-20240128-202157-1e552d76.Debian12.deb
# sudo apt install -y ./wezterm-20240128-202157-1e552d76.Debian12.deb
# rm wezterm-20240128-202157-1e552d76.Debian12.deb
# ---------------------------------------------------------------------------------------------------------------------------
# Wezterm
#curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
#echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
#sudo apt update && sudo apt install wezterm
echo ""
echo "DONE!"


