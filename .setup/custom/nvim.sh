if ! command -v nvim >/dev/null 2>&1; then
    echo "neovim not found"
    echo "downloading neovim..."
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
    
    echo "installing neovim..."
    sudo chmod a+x nvim-linux-x86_64.appimage
    sudo mkdir -p /opt/nvim
    sudo mv nvim-linux-x86_64.appimage /opt/nvim/nvim
fi
