#!/bin/bash

set -e

REPO="https://github.com/CameronHonis/dotfiles.git"
DEST="$HOME/.setup"

# install git if missing
if ! command -v git &>/dev/null; then
    echo "installing git..."
    sudo apt update
    sudo apt install -y git
    echo "git installed"
fi

# clone repo directly into $HOME/.setup
echo "cloning dotfiles..."
git clone "$REPO" "$DEST"
echo "dotfiles cloned"

# run setup
echo "running setup"
bash "$DEST/setup.sh"
