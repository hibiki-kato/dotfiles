#!/usr/bin/env zsh
set -euo pipefail

# Download and install JuliaMono font for math/Unicode support
if [ ! -d "/usr/local/share/fonts/JuliaMono" ]; then
  echo "Installing JuliaMono font..."
  sudo mkdir -p /usr/local/share/fonts/JuliaMono
  wget -qO- https://github.com/cormullion/juliamono/releases/latest/download/JuliaMono.tar.gz | sudo tar -xzf - -C /usr/local/share/fonts/JuliaMono
  sudo fc-cache -f
fi

sudo install -d -m 755 /etc/kmscon
cat <<'EOF' | sudo tee /etc/kmscon/kmscon.conf >/dev/null
font-name=JuliaMono
font-size=16
mouse
xkb-options=ctrl:nocaps
EOF

sudo locale-gen ja_JP.UTF-8
sudo update-locale LANG=ja_JP.UTF-8

if command -v systemctl >/dev/null 2>&1; then
  sudo systemctl disable getty@tty1.service || true
  sudo systemctl restart kmscon || true
fi
