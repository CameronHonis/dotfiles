set -e

cd "$HOME"

# use the newly created hardware config
mv "$HOME/.config/nixos/hardware-configuration.nix" "$HOME/.config/nixos/hardware-configuration.nix.backup" || true
sudo cp /etc/nixos/hardware-configuration.nix "$HOME/.config/nixos/"

if [ -d /etc/nixos ] && [ ! -L /etc/nixos ]; then
    sudo mv /etc/nixos /etc/nixos.backup
fi

sudo ln -sf "$HOME/.config/nixos" /etc/nixos


sudo nixos-rebuild switch --flake /etc/nixos/#rook
