#!/usr/bin/env bash

set -e

updates=$(sudo apt-get -s -o Debug::NoLocking=true upgrade | grep -c ^Inst)
if [[ $updates -gt 0 ]]; then
    notify-send "Number of updates available: $updates"
fi
