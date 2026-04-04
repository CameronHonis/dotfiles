#!/bin/bash

set -e

REPO="https://github.com/CameronHonis/dotfiles.git"
DEST="$HOME/.setup"

# install git if missing
if ! command -v git &>/dev/null; then
  sudo apt update
  sudo apt install -y git
fi

# clone repo directly into $HOME/.setup
git clone "$REPO" "$DEST"

# run setup
bash "$DEST/setup.sh"
