if ! which kitty >/dev/null 2>&1; then
    echo "kitty not found"
    echo "downloading kitty..."
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

    # Create symbolic links to add kitty and kitten to PATH (assuming ~/.local/bin is in
    # your system-wide PATH)
    echo "installing kitty..."
    sudo ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten /usr/local/bin
    # Place the kitty.desktop file somewhere it can be found by the OS
    cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
    # If you want to open text files and images in kitty via your file manager also add the kitty-open.desktop file
    cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
    # Update the paths to the kitty and its icon in the kitty desktop file(s)
    sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
    sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
    # Make xdg-terminal-exec (and hence desktop environments that support it use kitty)
    echo 'kitty.desktop' > ~/.config/xdg-terminals.list

    # register terminfo
    sudo ln -s ~/.local/kitty.app/share/terminfo/x/xterm-kitty /usr/share/terminfo/x/xterm-kitty

    # set as default terminal (assuming no existing terminal has a priority >=
    # 51
    sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator ~/.local/kitty.app/bin/kitty 51

    echo "kitty installed"
fi
