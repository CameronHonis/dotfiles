#!/bin/bash

cd "$(dirname "$0")"

./base/apply_keys.sh
./base/apply_sources.sh
./base/install_packages.sh

# custom setup
for script in custom/*.sh; do
    sh "$script"
done

# set cron job to sync local packages with remote `manual_packages.txt`
CRON_JOB="0 2 * * * base/sync_to_remote.sh"
CRON_TMP=$(mktemp)

# Check if the cron job exists, if not add it
crontab -l 2>/dev/null | grep -F -q "$CRON_JOB"
if [ $? -ne 0 ]; then
  # Add the cron job
  crontab -l 2>/dev/null > "$CRON_TMP"
  echo "$CRON_JOB" >> "$CRON_TMP"
  crontab "$CRON_TMP"
fi

rm -f "$CRON_TMP"
