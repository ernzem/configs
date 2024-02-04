#!/bin/bash
mkdir ~/.fonts

cd /tmp
fonts=( 
"JetBrainsMono"  
)

for font in ${fonts[@]}
do
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/$font.zip
    unzip $font.zip -d $HOME/.fonts/$font/
    rm $font.zip
done
fc-cache
