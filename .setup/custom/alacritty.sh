if [ ! -d /opt/alacritty ]; then
    echo "alacritty not found"
    echo "downloading alacritty..."
    sudo git clone https://github.com/alacritty/alacritty.git /opt/alacritty
    sudo chmod 777 -R /opt/alacritty
    cd /opt/alacritty

    echo "installing alacritty..."
    cargo build --release --no-default-features --features=wayland
    echo "alacritty installed"

    sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
    sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
    sudo desktop-file-install extra/linux/Alacritty.desktop
    sudo update-desktop-database
fi

