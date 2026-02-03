#!/usr/bin/env zsh
set -euo pipefail

# Install Miniforge (Conda-forge) and uv on Ubuntu Desktop
# - Idempotent: skips if already installed
# - Non-interactive safe: no shell init modifications here

# Detect architecture for Miniforge
ARCH=$(uname -m)
case "$ARCH" in
	x86_64) MF_ARCH="x86_64" ;;
	aarch64|arm64) MF_ARCH="aarch64" ;;
	*) MF_ARCH="x86_64" ;;
esac

# Install Miniforge to $HOME/miniforge3 if missing
MINIFORGE_DIR="$HOME/miniforge3"
if [[ ! -x "$MINIFORGE_DIR/bin/conda" ]]; then
	wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-$MF_ARCH.sh -O ~/miniforge.sh
	zsh ~/miniforge.sh -b -p "$MINIFORGE_DIR"
	rm ~/miniforge.sh
	echo "PATH=$PATH:$HOME/miniforge3/bin" >> .zshrc
	source .zshrc
fi

# Hints (do not modify user shell files here)
echo "Miniforge path: $MINIFORGE_DIR (conda available)"