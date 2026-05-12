set -e

cd "$HOME"

if [ -d /etc/nixos ] && [ ! -L /etc/nixos ]; then
    sudo mv /etc/nixos /etc/nixos.backup
fi

sudo ln -sf "$HOME/.config/nixos" /etc/nixos

sudo nixos-rebuild switch --flake /etc/nixos/#rook
