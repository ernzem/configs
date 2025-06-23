#!/bin/bash

# for 1.20.1 version installation execute:
# bash go-linux-install.sh 1.20.1 && exec bash

# Exit if any command fails
set -e

FILE=go$1.linux-amd64.tar.gz

echo "Download ${FILE}..."
curl https://dl.google.com/go/${FILE} --output ${FILE}

echo " "
echo "Install ${FILE}..."
sudo bash -c "rm -rf /usr/local/go && tar -C /usr/local -xzf ${FILE}"

if [ -r ~/.bash_profile ];
    then
        echo " "
        echo "Profile file identified. Adding changes to it..."
    else
        echo " "
        echo "Profile file does not exists. Creating it..."
        touch ~/.bash_profile
fi

echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bash_profile

echo " "
echo "Reloading profile file.."
source ~/.bash_profile

echo " "
echo "Checking Go instalation by checking Golang version..."
go version

echo " "
echo "SUCCESS!!! Adding GOPATH to profile file..."
echo "export PATH=$(go env GOPATH)/bin:$PATH" >> ~/.bash_profile

echo " "
echo "Cleaning up..."
rm ${FILE}

echo " "
echo "Done!"
