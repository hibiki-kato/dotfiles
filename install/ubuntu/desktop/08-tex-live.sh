#!/usr/bin/env zsh
set -euo pipefail

# Install TeX Live via apt, then install tex-fmt.
# tex-fmt: prefer apt; fall back to Cargo if apt package is unavailable.

sudo apt-get update -y || true
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y texlive-full

# Make cargo visible if rustup installed it.
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

if command -v tex-fmt >/dev/null 2>&1; then
    echo "tex-fmt already installed: $(command -v tex-fmt)"
elif sudo DEBIAN_FRONTEND=noninteractive apt-get install -y tex-fmt; then
    echo "tex-fmt installed via apt"
else
    echo "tex-fmt not available via apt; installing via Cargo"
    if command -v cargo-binstall >/dev/null 2>&1; then
        cargo binstall --no-confirm tex-fmt || cargo install --locked tex-fmt
    else
        cargo install --locked tex-fmt
    fi
fi

tex-fmt --version