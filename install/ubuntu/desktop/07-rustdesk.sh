#!/usr/bin/env zsh
set -euo pipefail

sudo add-apt-repository ppa:pipewire-debian/pipewire-upstream -y
sudo apt update -y || true

# 誤ったディスク使用量レポートは無視してください
sudo apt install -fy ./rustdesk-<version>.deb