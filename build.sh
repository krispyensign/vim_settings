#!/bin/bash
set -ex
./get_plugins.sh
./sync_plugins.sh
./post_config.sh
./sync_settings.sh
