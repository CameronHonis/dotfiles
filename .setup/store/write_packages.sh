cd "$(dirname "$0")"

apt-mark showmanual | grep -v -f <(sed 's/*/.*/g' ignore_packages.txt) > manual_packages.txt
