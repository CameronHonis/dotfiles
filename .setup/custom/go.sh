if [ ! -d /usr/local/go ]; then
    if [ -e "$HOME/Downloads/go.1.24.3.linux-amd64.tar.gz"]; then
        rm ~/Downloads/go1.24.3.linux-amd64.tar.gz
    fi

    curl https://dl.google.com/go/go1.24.3.linux-amd64.tar.gz -o "$HOME/Downloads/go1.24.3.linux-amd64.tar.gz"
    sudo tar -C /usr/local -xzf "$HOME/Downloads/go1.24.3.linux-amd64.tar.gz"

    rm "$HOME/Downloads/go1.24.3.linux-amd64.tar.gz"
fi
