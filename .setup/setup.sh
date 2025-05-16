#!/bin/bash

# set appropriate CWD
cd "$(dirname "$0")"

sudo apt update -q

# apt installs
while IFS= read -r line; do
    # Trim leading/trailing whitespace
    line_trimmed=$(echo "$line" | xargs)

    # Skip empty lines and comments
    if [[ -z "$line_trimmed" || "$line_trimmed" == \#* ]]; then
        continue
    fi

    echo "Installing package: $line_trimmed"
    sudo apt-get install -y -qq "$line_trimmed"
done < "manual_packages.txt"

# custom setup
for script in custom/*.sh; do
    sh "$script"
done

# set cron job to sync local packages with remote `manual_packages.txt`
# probably prompt user to pick which new packages to track/ignore
