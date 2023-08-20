#!/bin/bash

# Exit if any command fails
set -e

flatpak install -y flathub com.spotify.Client
# flatpak install -y flathub com.mattjakeman.ExtensionManager
flatpak install -y flathub org.keepassxc.KeePassXC
flatpak install -y flathub org.mozilla.Thunderbird
#flatpak install -y flathub org.libreoffice.LibreOffice
# flatpak install -y flathub org.gnome.Calendar
# flatpak install -y flathub org.gnome.Geary
