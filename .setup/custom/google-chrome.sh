#!/bin/bash

set -e
trap 'echo "Error: google-chrome.sh failed at line $LINENO - command: $BASH_COMMAND"; exit 1' ERR

if command -v google-chrome &>/dev/null; then
    echo "Google Chrome is already installed. Skipping."
    exit 0
fi

echo "Installing Google Chrome..."

# Download and add Google's signing key
sudo mkdir -p /etc/apt/keyrings
wget -q -O /tmp/google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# Install the .deb package (it will also add Google's apt repo and signing key)
sudo apt install -y /tmp/google-chrome.deb

# Clean up
rm -f /tmp/google-chrome.deb

echo "Google Chrome installed successfully."
google-chrome --version
