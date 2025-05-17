cd "$(dirname "$0")"

if [ -d global_keys ]; then
    rm -rf global_keys
fi

if [ -d usr_keys ]; then
    rm -rf usr_keys
fi

sudo cp -r /etc/apt/keyrings global_keys
sudo cp -r /usr/share/keyrings usr_keys
