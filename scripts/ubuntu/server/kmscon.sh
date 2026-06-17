#!/usr/bin/env zsh
set -euo pipefail

sudo install -d -m 755 /etc/kmscon
cat <<'EOF' | sudo tee /etc/kmscon/kmscon.conf >/dev/null
font-name=Noto Sans Mono CJK JP
font-size=16
xkb-options=ctrl:nocaps
EOF

sudo locale-gen ja_JP.UTF-8
sudo update-locale LANG=ja_JP.UTF-8

if command -v systemctl >/dev/null 2>&1; then
  sudo systemctl disable getty@tty1.service || true
fi
