#!/bin/bash
set -euo pipefail
trap 'echo "Error: pia_vpn.sh failed at line $LINENO - command: $BASH_COMMAND"; exit 1' ERR

if command -v piactl &>/dev/null; then
    echo "PIA VPN is already installed. Skipping."
    exit 0
fi

INSTALLER="/tmp/pia-linux.run"
DOWNLOAD_URL="https://installers.privateinternetaccess.com/download/pia-linux-3.7.2-08420.run"

echo "Downloading PIA VPN installer..."
curl -fsSL "$DOWNLOAD_URL" -o "$INSTALLER"

echo "Running PIA VPN installer (requires sudo)..."
sudo bash "$INSTALLER" --nox

echo "Cleaning up..."
rm -f "$INSTALLER"

echo "Done! Use 'piactl' to manage your PIA connection."
