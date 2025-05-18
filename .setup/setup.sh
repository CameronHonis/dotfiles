#!/bin/bash

# parse args
skip_apt=false
case " $* " in
    *" --skip-apt "*)
        skip_apt=true
    ;;
    *)
        skip_apt=false
    ;;
esac


cd "$(dirname "$0")"

if [ "$skip_apt" != "true" ]; then
  ./base/apply_keys.sh -y
  ./base/apply_sources.sh -y
  ./base/install_packages.sh -y
fi


# custom setup
for script in custom/*.sh; do
    sh "$script"
done

# set cron job to sync local packages with remote `manual_packages.txt`
CRON_JOB="0 2 * * * $HOME/.setup/base/sync_to_remote.sh"
CRON_TMP=$(mktemp)

# Check if the cron job exists, if not add it
sudo crontab -l 2>/dev/null | grep -F -q "$CRON_JOB"
if [ $? -ne 0 ]; then
  # Add the cron job
  sudo crontab -l 2>/dev/null > "$CRON_TMP"
  echo "$CRON_JOB" >> "$CRON_TMP"
  sudo crontab "$CRON_TMP"
fi

rm -f "$CRON_TMP"
