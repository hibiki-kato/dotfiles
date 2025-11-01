#!/usr/bin/env zsh
set -euo pipefail

sudo apt-get update -y || true
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
  stacer \
    trash-cli

