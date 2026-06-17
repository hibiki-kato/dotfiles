#!/usr/bin/env zsh
set -euo pipefail

sudo systemctl enable --now bluetooth
sudo systemctl enable --now ssh