#!/bin/bash

# Exit if any command fails
set -e

# https://support.mozilla.org/en-US/kb/install-firefox-linux?_gl=1*1rj1xfo*_ga*MTc3MDQ4ODk1OS4xNzA2OTAxNTA3*_ga_MQ7767QQQW*MTcwNjkwMTUwNy4xLjAuMTcwNjkwMTUwNy4wLjAuMA..#w_install-firefox-deb-package-for-debian-based-distributions

sudo install -d -m 0755 /etc/apt/keyrings
sudo apt-get install -y wget
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); print "\n"$0"\n"}'
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla
sudo apt-get update && sudo apt-get install firefox

echo "New Firefox Installed.\nTrying to remove \"Firefox ESR\"..."
sudo apt purge -y firefox-esr

echo "\nDone!\n"


