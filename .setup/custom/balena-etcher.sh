#!/bin/bash

set -e
trap 'echo "Error: balena-etcher.sh failed at line $LINENO - command: $BASH_COMMAND"; exit 1' ERR

if command -v balena-etcher &>/dev/null || dpkg -l balena-etcher 2>/dev/null | grep -q '^ii'; then
    echo "Balena Etcher is already installed. Skipping."
    exit 0
fi

VERSION="2.1.4"
DEB_FILE="/tmp/balena-etcher_${VERSION}_amd64.deb"
DOWNLOAD_URL="https://github.com/balena-io/etcher/releases/download/v${VERSION}/balena-etcher_${VERSION}_amd64.deb"

echo "Downloading Balena Etcher v${VERSION} .deb package..."
curl -fsSL "$DOWNLOAD_URL" -o "$DEB_FILE"

echo "Installing Balena Etcher via apt..."
sudo apt install -y "$DEB_FILE"

echo "Cleaning up..."
rm -f "$DEB_FILE"

echo "Balena Etcher installed successfully."
