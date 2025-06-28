#!/bin/bash*+

# RUN WITHOUT SUDO

# Exit if any command fails
set -e

if [ -d "${HOME}/.local/share/gnome-shell/extensions/unite@hardpixel.eu/" ]; then
  gnome-extensions enable unite@hardpixel.eu
fi




