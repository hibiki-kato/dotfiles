#!/usr/bin/env zsh
set -euo pipefail

export HOMEBREW_NO_SANDBOX_LINUX=1
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_ASK=1

linuxbrew_prefix="/home/linuxbrew/.linuxbrew"
if ! command -v brew >/dev/null 2>&1 && [[ -x "${linuxbrew_prefix}/bin/brew" ]]; then
  eval "$("${linuxbrew_prefix}/bin/brew" shellenv zsh)"
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "brew is not available; skipping server Homebrew packages." >&2
  exit 0
fi

brew trust normen/tap || true

brew install -y \
  chawan \
  meli \
  normen/tap/whatscli

# whatscli is built with CGO_ENABLED=0 by default, but go-sqlite3 requires CGO.
# Patch the formula and rebuild from source to enable CGO.
whatscli_formula="$(brew --prefix)/Homebrew/Library/Taps/normen/homebrew-tap/Formula/whatscli.rb"
if [[ -f "$whatscli_formula" ]] && ! grep -q 'CGO_ENABLED' "$whatscli_formula"; then
  sed -i 's|system "go", "build", \*std_go_args|ENV["CGO_ENABLED"] = "1"\n    system "go", "build", *std_go_args(ldflags: "-s -w")|' "$whatscli_formula"
  brew reinstall --build-from-source normen/tap/whatscli || true
fi
