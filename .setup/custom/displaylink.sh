#!/bin/bash
set -euo pipefail
trap 'echo "Error: displaylink.sh failed at line $LINENO - command: $BASH_COMMAND"; exit 1' ERR

if dpkg -s displaylink-driver &>/dev/null; then
    echo "DisplayLink driver is already installed. Skipping."
    exit 0
fi

echo "Installing DisplayLink driver via Synaptics APT repository..."

sudo apt-get update -y
sudo apt-get install -y ./Downloads/synaptics-repository-keyring.deb 2>/dev/null || {
    curl -fsSL -o /tmp/synaptics-repository-keyring.deb \
        https://www.synaptics.com/sites/default/files/Ubuntu/pool/stable/main/all/synaptics-repository-keyring.deb
    sudo apt-get install -y /tmp/synaptics-repository-keyring.deb
    sudo rm -f /tmp/synaptics-repository-keyring.deb
}

sudo apt-get update -y
sudo apt-get install -y displaylink-driver

echo "Done. Reboot if needed."
