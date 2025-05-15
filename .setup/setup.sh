#!/bin/bash

# set appropriate CWD
cd "$(dirname "$0")"

sudo apt update -q

# apt installs
xargs sudo apt-get install -y -q < manual_packages.txt

# custom setup
for script in custom/*.sh; do
    sh "$script"
done

# set cron job to sync local packages with remote `manual_packages.txt`
# probably prompt user to pick which new packages to track/ignore
