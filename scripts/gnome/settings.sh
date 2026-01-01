#!/bin/bash

# RUN WITHOUT SUDO

# Exit if any command fails
set -e

GET_RELEASE_SCRIPT_PATH="${HOME}/.cfg/scripts/github-get-latest-release.sh"
TMP_FOLDER="${HOME}/tmp"

if [ ! -e ${GET_RELEASE_SCRIPT_PATH} ]; then
    echo "ERROR: script \"${GET_RELEASE_SCRIPT_PATH}\" not found!"
    exit 1
fi

mkdir -p "${TMP_FOLDER}"

#================================GNOME==================================================
echo "Applying gnome settings..."

# Disable conflicting keybindings
gsettings set org.gnome.shell.keybindings toggle-overview "[]"
gsettings set org.gnome.desktop.wm.keybindings activate-window-menu "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "[]"
gsettings set org.gnome.shell.keybindings toggle-quick-settings "['<Shift><Super>s']"
gsettings set org.gnome.desktop.wm.keybindings close "['<Super><Shift>Q']"

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

# Disable thumbnails
gsettings set org.gnome.desktop.thumbnailers disable "['application/pdf']"

# disable hot corners
gsettings set org.gnome.desktop.interface enable-hot-corners false

# Show battery percentage
gsettings set org.gnome.desktop.interface show-battery-percentage true

# Keyboard input source: lt+us
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'lt+us')]"

# Time format to 24h
gsettings set org.gnome.desktop.interface clock-format "24h"

# Pin favorite applications to dock
gsettings set org.gnome.shell favorite-apps "['brave-browser.desktop', 'codium.desktop', 'foot.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Calculator.desktop', 'libreoffice-writer.desktop', 'libreoffice-calc.desktop', 'ca.desrt.dconf-editor.desktop', 'org.gnome.Software.desktop', 'org.keepassxc.KeePassXC.desktop', 'timeshift-gtk.desktop']"

#================================APP-SETTINGS==================================================
# Disable evolution services
# sudo chmod -x /usr/libexec/evolution-data-server/evolution-alarm-notify
# sudo chmod -x /usr/libexec/evolution-source-registry
# sudo chmod -x /usr/libexec/evolution-addressbook-factory
# sudo chmod -x /usr/libexec/evolution-calendar-factory

#=======================================GNOME EXTENSIONS===========================================================
# Imports functions for downloading latest release or retrieving latest release url
source $GET_RELEASE_SCRIPT_PATH

download_latest_release "hardpixel/unite-shell" "unite.*\.zip\"" "${TMP_FOLDER}/unite.zip"
gnome-extensions install --force ${TMP_FOLDER}/unite.zip

# Alternative: download & install from gnome store
#~ gdbus call --session \
           #~ --dest org.gnome.Shell.Extensions \
           #~ --object-path /org/gnome/Shell/Extensions \
           #~ --method org.gnome.Shell.Extensions.InstallRemoteExtension \
           #~ "middleclickclose@paolo.tranquilli.gmail.com"

gsettings --schemadir ~/.local/share/gnome-shell/extensions/unite@hardpixel.eu/schemas/ set org.gnome.shell.extensions.unite notifications-position 'center'
gsettings --schemadir ~/.local/share/gnome-shell/extensions/unite@hardpixel.eu/schemas/ set org.gnome.shell.extensions.unite window-buttons-placement 'last'
gsettings --schemadir ~/.local/share/gnome-shell/extensions/unite@hardpixel.eu/schemas/ set org.gnome.shell.extensions.unite reduce-panel-spacing false
gsettings --schemadir ~/.local/share/gnome-shell/extensions/unite@hardpixel.eu/schemas/ set org.gnome.shell.extensions.unite extend-left-box false
gsettings --schemadir ~/.local/share/gnome-shell/extensions/unite@hardpixel.eu/schemas/ set org.gnome.shell.extensions.unite hide-app-menu-icon false

echo "To enable extensions, logout or restart pc!"

#~ gnome-extensions enable unite@hardpixel.eu

#=======================================CLEANUP===========================================================
rm -r $TMP_FOLDER
