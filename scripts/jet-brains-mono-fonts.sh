#!/bin/bash

# Exit if any command fails
set -e

mkdir -p ~/.fonts

GET_RELEASE_SCRIPT_PATH="${HOME}/.cfg/scripts/github-get-latest-release.sh"
TMP_FOLDER="${HOME}/tmp"

if [ ! -e ${GET_RELEASE_SCRIPT_PATH} ]; then
    echo "ERROR: script \"${GET_RELEASE_SCRIPT_PATH}\" not found!"
    exit 1
fi

#~ Imports functions for downloading latest release or retrieving latest release url
source $GET_RELEASE_SCRIPT_PATH 

fonts=( 
	"JetBrainsMono"  
)

mkdir $TMP_FOLDER

for font in ${fonts[@]}
do
    download_latest_release "JetBrains/JetBrainsMono" "JetBrainsMono.*\.zip\"" "${TMP_FOLDER}/${font}.zip"
    unzip $TMP_FOLDER/$font.zip -d $HOME/.fonts/$font/
done

rm -r $TMP_FOLDER
