if [ ! -d $HOME/.cargo/bin ]; then
    echo "rustup not found"
    echo "downloading rustup..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    echo "rustup downloaded"
fi
