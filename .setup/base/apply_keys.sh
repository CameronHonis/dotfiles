cd "$(dirname "$0")"

# assert that keys exist before deleting existing
if [ ! -d global_keys ]; then
    echo "global_keys does not exist, exiting to prevent key loss"
    exit
elif [ -z "$(ls -A global_keys)" ]; then
    echo "global_keys is empty, exiting to prevent key loss"
    exit
fi

if [ ! -d usr_keys ]; then
    echo "usr_keys does not exist, exiting to prevent key loss"
    exit
elif [ -z "$(ls -A usr_keys)" ]; then
    echo "usr_keys is empty, exiting to prevent key loss"
    exit
fi

if [[ ! "$@" == *"-y"* ]]; then
    while true; do
      read -p "Applying package keys will delete all existing keys on this machine. Are you sure you wish to continue? (y/n): " answer
      case "${answer,,}" in  # converts to lowercase
        y|yes ) break ;;
        n|no  ) echo "You answered no. exiting."; exit ;;
        * ) echo "answer only with 'y', 'yes', 'n', or 'no'." ;;
      esac
    done
fi

sudo rm /etc/apt/keyrings/*
sudo rm /usr/share/keyrings/*

sudo cp global_keys/* /etc/apt/keyrings/
sudo cp usr_keys/* /usr/share/keyrings/
