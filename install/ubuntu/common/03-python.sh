#!/usr/bin/env zsh
set -euo pipefail

# Install Miniforge (Conda-forge) and uv on Ubuntu Desktop
# - Idempotent: skips if already installed
# - Idempotent: skips if already installed and avoids duplicate shell init lines

# Detect architecture for Miniforge
ARCH=$(uname -m)
case "$ARCH" in
	x86_64) MF_ARCH="x86_64" ;;
	aarch64|arm64) MF_ARCH="aarch64" ;;
	*) MF_ARCH="x86_64" ;;
esac

# Install Miniforge to $HOME/miniforge3 if missing.
MINIFORGE_DIR="$HOME/miniforge3"
if [[ -d "$MINIFORGE_DIR" ]]; then
	echo "Miniforge directory already exists, skipping install: $MINIFORGE_DIR"
elif command -v conda >/dev/null 2>&1; then
	echo "conda already available, skipping Miniforge install: $(command -v conda)"
else
	wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-$MF_ARCH.sh -O ~/miniforge.sh
	# Use bash to avoid zsh glob pattern issues during installation
	bash ~/miniforge.sh -b -p "$MINIFORGE_DIR"
	rm ~/miniforge.sh
fi

echo "Miniforge path: $MINIFORGE_DIR (conda available)"
