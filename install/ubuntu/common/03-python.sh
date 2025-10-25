#!/usr/bin/env bash
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
	TMP_SH="/tmp/Miniforge3-Linux-${MF_ARCH}.sh"
	URL="https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-${MF_ARCH}.sh"
	echo "Downloading Miniforge installer (${MF_ARCH})..."
	curl -fsSL "$URL" -o "$TMP_SH"
	bash "$TMP_SH" -b -p "$MINIFORGE_DIR"
	rm -f "$TMP_SH"
fi

# Install uv if missing
if ! command -v uv >/dev/null 2>&1; then
	echo "Installing uv..."
	export UV_INSTALL_DIR="$HOME/.local/bin"
	mkdir -p "$UV_INSTALL_DIR"
	# Official installer (non-interactive)
	curl -fsSL https://astral.sh/uv/install.sh | sh || true
fi

# Hints (do not modify user shell files here)
echo "Miniforge path: $MINIFORGE_DIR (conda available)"
echo "uv path: $(command -v uv 2>/dev/null || echo "$HOME/.local/bin/uv (after next shell)")"
