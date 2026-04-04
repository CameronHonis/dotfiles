#!/bin/bash

set -e
trap 'echo "Error: discord.sh failed at line $LINENO - command: $BASH_COMMAND"; exit 1' ERR

if command -v discord &>/dev/null; then
  echo "Discord is already installed."
  exit 0
fi

DEB_URL="https://discord.com/api/download?platform=linux"
DEB_FILE="/tmp/discord.deb"

echo "Downloading Discord..."
curl -fsSL "$DEB_URL" -o "$DEB_FILE"

echo "Installing Discord..."
sudo dpkg -i "$DEB_FILE" || sudo apt-get install -f -y

echo "Cleaning up..."
rm "$DEB_FILE"

echo "Done!"
