cd "$(dirname "$0")"

mkdir -p sources
rm -rf sources/*

sudo cp /etc/apt/sources.list sources/
sudo cp -R /etc/apt/sources.list.d/ sources/sources.list.d/
