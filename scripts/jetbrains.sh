#!/bin/bash
mkdir ~/.fonts

cd /tmp
fonts=( 
"JetBrains Mono"  
)

for font in ${fonts[@]}
do
    wget https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip -O ${font}.zip
    unzip $font.zip -d $HOME/.fonts/$font/
    rm $font.zip
done
fc-cache