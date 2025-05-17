cd "$(dirname "$0")"

./record_keys.sh
./record_sources.sh
./record_packages.sh

if [[ $(git status --porcelain "$HOME/.setup/") ]]; then
    git add "$HOME/.setup/"
    git commit -m "auto commit by setup sync"
    git push
fi
