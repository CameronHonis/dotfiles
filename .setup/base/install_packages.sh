cd "$(dirname "$0")"

sudo apt update -q

# apt installs
while IFS= read -r line; do
    # Trim leading/trailing whitespace
    line_trimmed=$(echo "$line" | xargs)

    # skip empty
    if [[ -z "$line_trimmed" || "$line_trimmed" == \#* ]]; then
        continue
    fi

    echo "Installing package: $line_trimmed"
    sudo apt-get install -y -qq "$line_trimmed"
done < "../manual_packages.txt"
