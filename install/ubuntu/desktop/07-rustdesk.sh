#!/usr/bin/env zsh
set -euo pipefail

sudo add-apt-repository ppa:pipewire-debian/pipewire-upstream -y
sudo apt update -y || true

# 誤ったディスク使用量レポートは無視してください
# 誤ったディスク使用量レポートは無視してください
deb=$(ls ./rustdesk-*.deb 2>/dev/null | head -n1 || true)
if [ -n "$deb" ]; then
    sudo apt install -fy "$deb" || {
        sudo dpkg -i "$deb" || true
        sudo apt-get install -f -y
    }
else
    echo "No rustdesk .deb found; skipping installation." >&2
fi