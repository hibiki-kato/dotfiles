#!/usr/bin/env zsh
set -euo pipefail

# Pinned to match ~/.local/bin/unison on the UMD nodes (used by DNA sync.sh)
version="2.54.0"
unison_bin="$HOME/.local/bin/unison"

if [ -x "$unison_bin" ] && "$unison_bin" -version 2>/dev/null | grep -q "version $version"; then
  echo "Unison $version already installed, skipping."
  exit 0
fi

if [ "$(uname -m)" != "x86_64" ]; then
  echo "No static Unison build for $(uname -m); installing from apt instead."
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y unison
  exit 0
fi

tmpdir="$(mktemp -d)"
trap 'command rm -rf "$tmpdir"' EXIT

name="unison-${version}-ubuntu-22.04-x86_64-static"
curl -fsSL -o "$tmpdir/$name.tar.gz" \
  "https://github.com/bcpierce00/unison/releases/download/v${version}/${name}.tar.gz"
tar -xzf "$tmpdir/$name.tar.gz" -C "$tmpdir"

mkdir -p "$(dirname "$unison_bin")"
install -m 755 "$tmpdir/$name/bin/unison" "$tmpdir/$name/bin/unison-fsmonitor" "$(dirname "$unison_bin")/"
echo "Unison installed at $unison_bin"
"$unison_bin" -version
