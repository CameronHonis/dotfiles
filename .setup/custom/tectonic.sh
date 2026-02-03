if ! which tectonic >/dev/null 2>&1; then
    echo "tectonic not found"
    echo "downloading and installing tectonic..."
    curl --proto '=https' --tlsv1.2 -fsSL https://drop-sh.fullyjustified.net | sh
    mkdir -p ~/.local/bin
    mv tectonic "$HOME/.local/bin/"
    echo "tectonic installed"
fi
