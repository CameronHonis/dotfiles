#!/bin/bash

# Ensure script runs as root using sudo if necessary
if [ "$EUID" -ne 0 ]; then
    echo "The script is not running as root."
    echo "Re-running as root with sudo..."
    exec sudo bash "$0" "$@"
    exit
fi

apt update

# apt installs
xargs sudo apt-get install -y < manual_packages.txt

#while IFS= read -r line; do
    ## Trim leading/trailing whitespace
    #line_trimmed=$(echo "$line" | xargs)

    ## Skip empty lines and comments
    #if [[ -z "$line_trimmed" || "$line_trimmed" == \#* ]]; then
        #continue
    #fi

    #echo "Installing package: $line_trimmed"
    #apt-get install -y "$line_trimmed"
#done < "manual_packages.txt"

#apt install cmake g++ pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 -y
#apt install google-chrome-stable -y
#apt install rustup -y

# manual download prebuilts
if [ ! -e "/opt/nivm/nvim" ]; then
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
    chmod a+x nvim-linux-x86_64.appimage
    mkdir -p /opt/nvim
    mv nvim-linux-x86_64.appimage /opt/nvim/nvim
fi
