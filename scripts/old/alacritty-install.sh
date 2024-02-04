#!/bin/bash

# Exit if any command fails
set -e

# for 1.20.1 version installation execute:
# bash alacritty-install.sh && exec bash
# Source: https://github.com/alacritty/alacritty/blob/master/INSTALL.md

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo version

git clone https://github.com/alacritty/alacritty.git
cd alacritty

sudo apt install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

cargo build --release

# Terminfo
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

# Desktop entry
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

# Man page
sudo mkdir -p /usr/local/share/man/man1
gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
gzip -c extra/alacritty-msg.man | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null

# Bash shell completion
mkdir -p ~/.bash_completion
cp extra/completions/alacritty.bash ~/.bash_completion/alacritty
echo "source ~/.bash_completion/alacritty" >> ~/.bashrc

echo "Cleaning up..."

cd ..
rm alacritty

echo "Done!"


