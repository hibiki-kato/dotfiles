#!/usr/bin/env zsh
set -euo pipefail

if [ ! -x "$HOME/pi-apps/manage" ]; then
  echo "Pi-Apps is required. Run 01-prereqs.sh first." >&2
  exit 1
fi

install_pi_app() {
  local app="$1"
  "$HOME/pi-apps/manage" install "$app"
}

install_pi_app "RustDesk"
install_pi_app "Brave"
