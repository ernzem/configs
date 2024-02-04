#!/bin/bash

# Exit if any command fails
set -e


# Stop docker autostart docker
sudo systemctl disable docker.service
sudo systemctl disable containerd.service





