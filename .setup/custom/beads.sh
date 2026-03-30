#!/bin/bash

set -e
trap 'echo "Error: beads.sh failed at line $LINENO - command: $BASH_COMMAND"; exit 1' ERR

if command -v bd &>/dev/null; then
    echo "Beads is already installed. Skipping."
    exit 0
fi

echo "Installing Beads..."
curl -fsSL https://raw.githubusercontent.com/steveyegge/beads/main/scripts/install.sh | bash

echo "Beads installed successfully."
