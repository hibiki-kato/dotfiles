#!/usr/bin/env bash
# CUDA Toolkit installation script for Ubuntu (Desktop, zsh)
# Skips if nvcc already exists
# Reference: https://docs.nvidia.com/cuda/cuda-installation-guide-linux/

set -euo pipefail

CUDA_VERSION="12.6.2"
ARCH="$(uname -m)"
UBUNTU_VERSION="$(lsb_release -sr)"
UBUNTU_MAJOR="${UBUNTU_VERSION%%.*}"

if command -v nvcc >/dev/null 2>&1; then
  echo "[INFO] nvcc already exists. Skipping CUDA installation."
  exit 0
fi

echo "[INFO] Installing CUDA Toolkit ${CUDA_VERSION} for Ubuntu ${UBUNTU_VERSION} (${ARCH})"

# Clean old NVIDIA packages
sudo apt remove --purge -y '*nvidia*' || true
sudo apt autoremove -y
sudo apt clean

# Choose supported repo (fallback for new Ubuntu versions)
case "$UBUNTU_MAJOR" in
  20) REPO_VER="ubuntu2004" ;;
  22) REPO_VER="ubuntu2204" ;;
  24|25) REPO_VER="ubuntu2404" ;;  # fallback for Ubuntu 24.04+ (incl. 25.x)
  *) REPO_VER="ubuntu2204" ;;
esac

# Add NVIDIA repo
cd /tmp
wget https://developer.download.nvidia.com/compute/cuda/repos/${REPO_VER}/${ARCH}/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt update -y

# Install CUDA Toolkit (no driver)
sudo apt install -y cuda-toolkit

# Update environment for zsh
ZSHRC="${HOME}/.zshrc"
if ! grep -q "/usr/local/cuda/bin" "$ZSHRC"; then
cat <<'EOF' >> "$ZSHRC"

# CUDA Toolkit
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
EOF
fi

echo "[INFO] CUDA Toolkit ${CUDA_VERSION} installed successfully."
echo "[INFO] Run 'source ~/.zshrc' to apply environment changes."