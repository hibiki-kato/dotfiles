#!/usr/bin/env bash
set -euo pipefail

# Install TeX Live (user-local) via upstream installer (quickinstall)
# - Non-interactive using a profile (scheme-small, no docs/src)
# - Installs under $HOME/texlive/<year>
# - Adds a stable symlink $HOME/texlive/bin -> .../bin/<arch>

# Prerequisites
sudo apt-get update -y || true
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
	perl \
	wget \
	curl \
	xz-utils \
	tar \
	fontconfig \
	ghostscript || true

ARCH=$(uname -m)
case "$ARCH" in
	x86_64) TL_ARCH="x86_64-linux" ;;
	aarch64|arm64) TL_ARCH="aarch64-linux" ;;
	*) TL_ARCH="x86_64-linux" ;;
esac

YEAR=$(date +%Y)
TEXDIR="$HOME/texlive/${YEAR}"
TEXMFLOCAL="$HOME/texlive/texmf-local"
TEXMFSYSCONFIG="$HOME/texlive/${YEAR}/texmf-config"
TEXMFSYSVAR="$HOME/texlive/${YEAR}/texmf-var"
TEXMFHOME="$HOME/texmf"

if [[ -x "$TEXDIR/bin/$TL_ARCH/tex" ]]; then
	# Already installed for this year
	exit 0
fi

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

INSTALL_TL_TGZ="$TMPDIR/install-tl-unx.tar.gz"
curl -fsSL https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz -o "$INSTALL_TL_TGZ"
tar -xzf "$INSTALL_TL_TGZ" -C "$TMPDIR"
TL_DIR=$(find "$TMPDIR" -maxdepth 1 -type d -name 'install-tl-*' | head -n1)

PROFILE="$TMPDIR/texlive.profile"
cat > "$PROFILE" <<EOF
selected_scheme scheme-small
TEXDIR $TEXDIR
TEXMFLOCAL $TEXMFLOCAL
TEXMFSYSCONFIG $TEXMFSYSCONFIG
TEXMFSYSVAR $TEXMFSYSVAR
TEXMFHOME $TEXMFHOME
binary_$TL_ARCH 1
instopt_adjustpath 0
instopt_letter 0
instopt_portable 0
tlpdbopt_autobackup 1
tlpdbopt_backupdir tlpkg/backups
tlpdbopt_install_docfiles 0
tlpdbopt_install_srcfiles 0
tlpdbopt_repository https://mirror.ctan.org/systems/texlive/tlnet
EOF

perl "$TL_DIR/install-tl" -profile "$PROFILE"

# Stable bin symlink and tlmgr basics
mkdir -p "$HOME/texlive"
ln -sfn "$TEXDIR/bin/$TL_ARCH" "$HOME/texlive/bin"

export PATH="$TEXDIR/bin/$TL_ARCH:$PATH"
tlmgr option repository https://mirror.ctan.org/systems/texlive/tlnet || true
tlmgr update --self || true
tlmgr install latexmk collection-latexrecommended || true

echo "TeX Live installed under $TEXDIR. PATH symlink at $HOME/texlive/bin"
