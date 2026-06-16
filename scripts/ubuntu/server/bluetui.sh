#!/usr/bin/env zsh
set -euo pipefail

export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"

if command -v bluetui >/dev/null 2>&1; then
  echo "bluetui already installed, skipping."
  exit 0
fi

if ! command -v cargo >/dev/null 2>&1; then
  echo "cargo is not available; skipping bluetui install." >&2
  exit 0
fi

src_dir="$HOME/.local/src/bluetui"
mkdir -p "$(dirname "$src_dir")" "$HOME/.local/bin"

if [[ -d "$src_dir/.git" ]]; then
  git -C "$src_dir" pull --ff-only
else
  git clone https://github.com/pythops/bluetui "$src_dir"
fi

cargo build --release --manifest-path "$src_dir/Cargo.toml"
install -m 755 "$src_dir/target/release/bluetui" "$HOME/.local/bin/bluetui"
