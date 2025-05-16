if [ ! -d $HOME/.cargo/bin ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
