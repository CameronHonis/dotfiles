set -e

REPO="https://github.com/CameronHonis/dotfiles.git"

cd "$HOME"

# clone repo directly into $HOME/.setup using nix-shell
echo "cloning dotfiles..."
nix-shell -p git --run "sh -s" << 'EOF'
git init
git remote add origin https://github.com/CameronHonis/dotfiles.git
git fetch
git checkout -f main
EOF
echo "dotfiles cloned"

# run setup
echo "running setup"
bash ".setup/setup.sh"
