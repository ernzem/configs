#!/bin/bash

mkdir -p ~/.ssh

# set local file permissions
chmod 700 ~/.ssh
#chmod 644 ~/.ssh/authorized_keys
#chmod 644 ~/.ssh/known_hosts
#chmod 644 ~/.ssh/config
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub

sudo apt install -y git
git clone git@github.com:ernzem/configs.git
mv configs ~/.cfg

echo "Applying configs...."
cd $HOME/.cfg
./install

echo "Done!"
