#!/usr/bin/env zsh
set -euo pipefail

# Install TeX Live (user-local) via upstream installer (quickinstall)
# - Non-interactive using a profile (scheme-small, no docs/src)
# - Installs under $HOME/texlive/<year>
# - Adds a stable symlink $HOME/texlive/bin -> .../bin/<arch>

# Prerequisites
sudo apt-get update -y || true
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y texlive-full

sudo apt-get install -y tex-fmt