#!/bin/bash

set -e

REPO="https://github.com/CameronHonis/dotfiles.git"
DEST="$HOME"

# clone repo directly into $HOME/.setup using nix-shell
echo "cloning dotfiles..."
nix-shell -p git --run "git clone $REPO $DEST"
echo "dotfiles cloned"

# run setup
echo "running setup"
bash "$DEST/setup.sh"
