#!/bin/zsh
set -euo pipefail

if command -v dropboxignore >/dev/null 2>&1; then
    echo "dropboxignore is already installed"
    exit 0
fi

echo "Installing dropboxignore..."
tmpdir=$(mktemp -d)
git clone --depth 1 https://codeberg.org/sp1thas/dropboxignore.git "$tmpdir"
cd "$tmpdir"
sudo make install
cd -
rm -rf "$tmpdir"
echo "✓ dropboxignore installed"