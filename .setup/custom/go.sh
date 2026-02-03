if [ ! -d /usr/local/go ]; then
    echo "go not found"
    if [ -e "$HOME/Downloads/go.1.24.3.linux-amd64.tar.gz"]; then
        rm ~/Downloads/go1.24.3.linux-amd64.tar.gz
    fi

    echo "downloading go..."
    curl https://dl.google.com/go/go1.24.3.linux-amd64.tar.gz -o "$HOME/Downloads/go1.24.3.linux-amd64.tar.gz"
    sudo tar -C /usr/local -xzf "$HOME/Downloads/go1.24.3.linux-amd64.tar.gz"
    echo "downloaded go prebuilt binary"

    rm "$HOME/Downloads/go1.24.3.linux-amd64.tar.gz"
fi
