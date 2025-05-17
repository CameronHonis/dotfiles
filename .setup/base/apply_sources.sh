cd "$(dirname "$0")"

# assert that keys exist before deleting existing
if [ ! -d sources ]; then
    echo "sources dir does not exist, exiting to prevent key loss"
    exit
fi

if [ ! -d sources/sources.list.d/ ]; then
    echo "sources.list.d does not exist, exiting to prevent key loss"
    exit
elif [ -z "$(ls -A sources/sources.list.d/)" ]; then
    echo "sources.list.d is empty, exiting to prevent key loss"
    exit
fi

if [ ! -f sources/sources.list ]; then
    echo "sources.list does not exist, exiting to prevent key loss"
    exit
fi

if [[ ! "$@" == *"-y"* ]]; then
    while true; do
      read -p "Applying package sources will delete all existing sources on this machine. Are you sure you wish to continue? (y/n): " answer
      case "${answer,,}" in  # converts to lowercase
        y|yes ) break ;;
        n|no  ) echo "You answered no. exiting."; exit ;;
        * ) echo "answer only with 'y', 'yes', 'n', or 'no'." ;;
      esac
    done
fi

sudo rm /etc/apt/sources.list.d/*

sudo cp sources/sources.list.d/* /etc/apt/sources.list.d/
sudo tee /etc/apt/sources.list < sources/sources.list
