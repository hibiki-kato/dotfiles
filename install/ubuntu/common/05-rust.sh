#!/usr/bin/env zsh
set -euo pipefail

# Install Rust toolchain via rustup.

# System prerequisites for rustup and crates that need native builds
sudo apt-get update -y || true
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
  build-essential \
  ca-certificates \
  curl \
  pkg-config \
  libssl-dev

# Keep paths explicit
export CARGO_HOME="${CARGO_HOME:-$HOME/.cargo}"
export RUSTUP_HOME="${RUSTUP_HOME:-$HOME/.rustup}"

# Make cargo/rustup visible in this script even before opening a new shell
if [[ -f "$CARGO_HOME/env" ]]; then
  source "$CARGO_HOME/env"
else
  export PATH="$CARGO_HOME/bin:$PATH"
fi

# Install rustup only when it is not already present. Do not update on bootstrap reruns.
if command -v rustup >/dev/null 2>&1 || [[ -x "$CARGO_HOME/bin/rustup" ]] || [[ -d "$RUSTUP_HOME" ]]; then
  echo "rustup already installed, skipping install/update."
else
  curl --proto '=https' --tlsv1.2 -fsSL https://sh.rustup.rs | sh -s -- -y --profile default
  [[ -f "$CARGO_HOME/env" ]] && source "$CARGO_HOME/env"
fi

if ! command -v rustup >/dev/null 2>&1; then
  echo "rustup state exists but rustup is not on PATH; skipping Rust toolchain changes."
  exit 0
fi

# Install stable toolchain only when missing.
if rustup toolchain list | grep -q '^stable'; then
  echo "Rust stable toolchain already installed, skipping."
else
  rustup toolchain install stable
  rustup default stable
fi

# Useful Rust components
rustup component add rustfmt clippy rust-analyzer || true

# Install cargo-binstall for faster installation of Rust CLI tools when binaries exist
if ! command -v cargo-binstall >/dev/null 2>&1; then
  cargo install --locked cargo-binstall
else
  echo "cargo-binstall already installed."
fi

rustc --version
cargo --version
