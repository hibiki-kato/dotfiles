#!/usr/bin/env zsh
set -euo pipefail

sudo apt install software-properties-common
sudo add-apt-repository ppa:pipewire-debian/pipewire-upstream
sudo apt update
# 誤ったディスク使用量レポートは無視してください
sudo apt install -fy ./rustdesk-<version>.deb