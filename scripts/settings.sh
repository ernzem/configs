#!/bin/bash

# RUN WITHOUT SUDO

# Exit if any command fails
set -e

#================================GNOME==================================================
echo "Applying gnome settings..."

# Disable conflicting keybindings
gsettings set org.gnome.shell.keybindings toggle-overview "[]"
gsettings set org.gnome.desktop.wm.keybindings activate-window-menu "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "[]"
gsettings set org.gnome.desktop.wm.keybindings close "['<Super><Shift>Q']"
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'lt+us')]"

# Custom keybindings
gsettings set org.gnome.shell.keybindings switch-to-application-1 "['<Super>W']"
gsettings set org.gnome.shell.keybindings switch-to-application-2 "['<Super>S']"
gsettings set org.gnome.shell.keybindings switch-to-application-3 "['<Super>D']"
gsettings set org.gnome.shell.keybindings switch-to-application-4 "['<Super>E']"
# gsettings set org.gnome.shell.keybindings switch-to-application-5 "['<Super><Shift>S']"

# Tap on click
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true  

# Window Buttons
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"

# Remaps CapsLock as additional Super key
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier']"

# No workspaces
# gsettings set org.gnome.mutter dynamic-workspaces false
# gsettings set org.gnome.desktop.wm.preferences num-workspaces 1

# Legacy gnome-terminal titlebar
gsettings set org.gnome.Terminal.Legacy.Settings headerbar false

# Text scaling factor
# gsettings set org.gnome.desktop.interface text-scaling-factor 0.95

# Disable thumbnails
gsettings set org.gnome.desktop.thumbnailers disable "['application/pdf']"

# disable hot corners
gsettings set org.gnome.desktop.interface enable-hot-corners false

#================================APP-SETTINGS==================================================
echo "add bash settings file to .bashrc ..."
echo "# Import my setttings" >> ~/.bashrc
echo "source ~/.my_configs.bash" >> ~/.bashrc

# Disable evolution services
sudo chmod -x /usr/libexec/evolution-data-server/evolution-alarm-notify
sudo chmod -x /usr/libexec/evolution-source-registry
sudo chmod -x /usr/libexec/evolution-addressbook-factory
sudo chmod -x /usr/libexec/evolution-calendar-factory

# Remove games
sudo apt purge aisleriot five-or-more four-in-a-row gnome-2048 gnome-chess hitori gnome-klotski gnome-mahjongg gnome-mines gnome-nibbles gnome-robots gnome-sudoku gnome-taquin gnome-tetravex iagno lightsoff quadrapassel swell-foop tali

# Remove evolution
sudo apt remove evolution gnome-music yelp
