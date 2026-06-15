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

# Install or update rustup
if command -v rustup >/dev/null 2>&1; then
  echo "rustup already installed, updating."
  rustup self update
else
  curl --proto '=https' --tlsv1.2 -fsSL https://sh.rustup.rs | sh -s -- -y --profile default
fi

# Make cargo/rustup visible in this script even before opening a new shell
if [[ -f "$CARGO_HOME/env" ]]; then
  source "$CARGO_HOME/env"
else
  export PATH="$CARGO_HOME/bin:$PATH"
fi

# Ensure shell init contains cargo path
if [[ -f "$HOME/.zshrc" ]]; then
  if ! grep -q 'cargo/env' "$HOME/.zshrc"; then
    echo 'source "$HOME/.cargo/env"' >> "$HOME/.zshrc"
  fi
else
  echo 'source "$HOME/.cargo/env"' > "$HOME/.zshrc"
fi

# Install/update stable toolchain
rustup toolchain install stable
rustup default stable
rustup update stable

# Useful Rust components
rustup component add rustfmt clippy rust-analyzer

# Install cargo-binstall for faster installation of Rust CLI tools when binaries exist
if ! command -v cargo-binstall >/dev/null 2>&1; then
  cargo install --locked cargo-binstall
else
  echo "cargo-binstall already installed."
fi

rustc --version
cargo --version
