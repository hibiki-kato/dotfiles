#!/usr/bin/env bash
set -euo pipefail

echo "Building and installing Neovim 0.10.0 from source..."

BUILD_DIR="$(mktemp -d)"
trap 'rm -rf "$BUILD_DIR"' EXIT

git clone --branch v0.10.0 --depth 1 https://github.com/neovim/neovim.git "$BUILD_DIR/neovim"
cd "$BUILD_DIR/neovim"
make CMAKE_BUILD_TYPE=Release
sudo make install

echo "Neovim 0.10.0 installed successfully!"
