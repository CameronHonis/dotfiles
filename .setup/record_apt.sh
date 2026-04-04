#!/bin/bash

cd "$(dirname "$0")"

bash base/record_keys.sh
bash base/record_sources.sh
bash base/record_packages.sh
