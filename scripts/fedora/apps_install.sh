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
sudo dnf install -y gnome-extensions-app
sudo dnf group install -y c-development # Nvim needs c compiler but i install c dev tools
sudo dnf install -y podman
sudo dnf install -y keepassxc
sudo dnf install -y dconf-editor
sudo dnf install -y foot
sudo dnf install -y geany geany-themes geany-plugins-*
# sudo dnf install -y zsh
# sudo dnf install -y alacritty

# Bat 
sudo dnf install -y bat
mkdir -p ~/.local/bin
#~ TODO: this might not needed for FEDORA
ln -s /usr/bin/batcat ~/.local/bin/bat

# Brave Browser:
curl -fsS https://dl.brave.com/install.sh | sh

# Starship https://starship.rs/guide/#%F0%9F%9A%80-installation
curl -sS https://starship.rs/install.sh | sh

 # Flathub
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Flatpaks: Extensions Manager
# flatpak install flathub com.mattjakeman.ExtensionManager

# FZF installation
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# NVIM
mkdir -p ~/.local/bin
download_latest_release "neovim/neovim" ".*linux.*x86_64.appimage\"" "${HOME}/.local/bin/nvim"
chmod u+x ~/.local/bin/nvim

# Wezterm https://wezterm.org/install/linux.html
sudo dnf install -y $(latest_release_url "wezterm/wezterm" ".fedora39.x86_64.rpm\"")

# VSCodium
# https://vscodium.com/#install
sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h\n" | sudo tee -a /etc/yum.repos.d/vscodium.repo
sudo dnf install codium

# VSCode
# https://code.visualstudio.com/docs/setup/linux
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
dnf check-update
sudo dnf install code

# Sublime text 
# https://www.sublimetext.com/docs/linux_repositories.html
# sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
# sudo dnf config-manager addrepo --from-repofile=https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
# sudo dnf install sublime-text

echo ""
echo "DONE!"