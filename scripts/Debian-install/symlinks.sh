#!/bin/bash

# Exit if any command fails
set -e

# RUN WITHOUT SUDO


FAILAI_MOUNT_POINT=/mnt/failai

# Symlinks in Home folder
ln -s ${FAILAI_MOUNT_POINT} ~/Failai
ln -s ${FAILAI_MOUNT_POINT}/Desktop ~/Desktop
ln -s ${FAILAI_MOUNT_POINT}/Downloads ~/Downloads
ln -s ${FAILAI_MOUNT_POINT}/Templates ~/Templates
ln -s ${FAILAI_MOUNT_POINT}/Public ~/Public
ln -s ${FAILAI_MOUNT_POINT}/Documents ~/Documents
ln -s ${FAILAI_MOUNT_POINT}/Music ~/Music
ln -s ${FAILAI_MOUNT_POINT}/Pictures ~/Pictures
ln -s ${FAILAI_MOUNT_POINT}/Videos ~/Videos
ln -s ${FAILAI_MOUNT_POINT}/Downloads ~/Downloads
ln -s ${FAILAI_MOUNT_POINT}/Sync ~/Sync
