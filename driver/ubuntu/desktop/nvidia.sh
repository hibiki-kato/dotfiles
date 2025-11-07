#!/usr/bin/env zsh
set -euo pipefail

# Install NVIDIA proprietary driver (recommended) and CUDA Toolkit (optional)
# Non-interactive; suitable for chezmoi bootstrap.
# Controls:
#   CUDA_SOURCE=nvidia|ubuntu   (default: nvidia)
#   CUDA_VERSION=12-6           (example pinned version when CUDA_SOURCE=nvidia)
#   INSTALL_CUDA=true|false     (default: true)

: "${CUDA_SOURCE:=nvidia}"
: "${INSTALL_CUDA:=true}"
: "${CUDA_VERSION:=}"  # e.g., "12-6" for cuda-toolkit-12-6 (only if CUDA_SOURCE=nvidia)

if [[ $EUID -ne 0 ]]; then
  exec sudo -E zsh "$0" "$@"
fi

echo "[info] Starting NVIDIA driver (and optional CUDA) setup..."

# Failsafe 1: Check if NVIDIA GPU exists
if ! lspci | grep -iq nvidia; then
  echo "[skip] No NVIDIA GPU detected; skipping driver/CUDA installation." >&2
  exit 0
fi

# Failsafe 2: Check if NVIDIA driver is already installed and working
if command -v nvidia-smi >/dev/null 2>&1 && nvidia-smi >/dev/null 2>&1; then
  echo "[ok] NVIDIA driver already installed and working; skipping driver step." >&2
  DRIVER_INSTALLED=true
else
  DRIVER_INSTALLED=false
fi

# Also check if driver package is already installed (even if not loaded yet)
if dpkg -l | grep -q '^ii.*nvidia-driver-[0-9]'; then
  echo "[ok] NVIDIA driver package already installed; skipping driver package install." >&2
  DRIVER_INSTALLED=true
fi

# Blacklist nouveau to prevent conflicts with proprietary NVIDIA driver
NOUVEAU_CONF="/etc/modprobe.d/blacklist-nouveau.conf"
if [[ "$DRIVER_INSTALLED" != true ]]; then
  if [[ ! -f "$NOUVEAU_CONF" ]]; then
    echo "[info] Blacklisting nouveau..."
    cat > "$NOUVEAU_CONF" <<EOF
blacklist nouveau
options nouveau modeset=0
EOF
    # Failsafe 3: Rollback nouveau blacklist if initramfs update fails
    if ! update-initramfs -y -u; then
      echo "[error] Failed to update initramfs; rolling back nouveau blacklist." >&2
      rm -f "$NOUVEAU_CONF"
      exit 1
    fi
  fi

  # Ensure ubuntu-drivers is available
  if ! command -v ubuntu-drivers >/dev/null 2>&1; then
    echo "[info] Installing ubuntu-drivers-common..."
    DEBIAN_FRONTEND=noninteractive apt-get update -y
    DEBIAN_FRONTEND=noninteractive apt-get install -y ubuntu-drivers-common
  fi

  # Detect recommended driver
  DRIVER_PKG=$(ubuntu-drivers devices 2>/dev/null | awk '/recommended/ {print $3; exit}' || true)
  if [[ -z "${DRIVER_PKG:-}" ]]; then
    echo "[warn] No recommended NVIDIA driver found; skipping driver install." >&2
  else
    echo "[info] Installing driver package: ${DRIVER_PKG} ..."
    DEBIAN_FRONTEND=noninteractive apt-get update -y
    # Failsafe 4: Cleanup on driver installation failure
    if ! DEBIAN_FRONTEND=noninteractive apt-get install -y "$DRIVER_PKG" nvidia-settings; then
      echo "[error] Failed to install NVIDIA driver; attempting cleanup..." >&2
      apt-get -y autoremove || true
      apt-get -y autoclean || true
      if [[ -f "$NOUVEAU_CONF" ]]; then
        rm -f "$NOUVEAU_CONF"
        update-initramfs -y -u || true
      fi
      exit 1
    fi
    DRIVER_INSTALLED=true
  fi
fi

# -----------------------
# CUDA Toolkit (optional)
# -----------------------
install_cuda_from_nvidia_repo() {
  echo "[info] Adding NVIDIA CUDA APT repository (if needed)..."
  # Add keyring & repo only if not present
  if ! apt-key list 2>/dev/null | grep -qi "NVIDIA"; then
    # Use keyring under /usr/share/keyrings to avoid apt-key warnings
    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu$(. /etc/os-release; echo "${VERSION_ID//./}")/x86_64/3bf863cc.pub \
      | gpg --dearmor -o /usr/share/keyrings/nvidia-cuda-archive-keyring.gpg
  fi

  CODENAME="$(. /etc/os-release; echo "${UBUNTU_CODENAME:-$(lsb_release -sc 2>/dev/null || true)}")"
  REPO_FILE="/etc/apt/sources.list.d/nvidia-cuda.list"
  if [[ ! -f "$REPO_FILE" ]]; then
    echo "deb [signed-by=/usr/share/keyrings/nvidia-cuda-archive-keyring.gpg] https://developer.download.nvidia.com/compute/cuda/repos/${CODENAME}/x86_64 /" > "$REPO_FILE"
  fi

  DEBIAN_FRONTEND=noninteractive apt-get update -y

  local pkg="cuda-toolkit"
  if [[ -n "${CUDA_VERSION}" ]]; then
    # Expect form like 12-6 -> cuda-toolkit-12-6
    pkg="cuda-toolkit-${CUDA_VERSION}"
  fi

  echo "[info] Installing ${pkg} (NVIDIA repo)..."
  DEBIAN_FRONTEND=noninteractive apt-get install -y "${pkg}"
}

install_cuda_from_ubuntu_repo() {
  echo "[info] Installing CUDA toolkit from Ubuntu repos (may be older)..."
  DEBIAN_FRONTEND=noninteractive apt-get update -y
  DEBIAN_FRONTEND=noninteractive apt-get install -y nvidia-cuda-toolkit
}

if [[ "${INSTALL_CUDA}" == true ]]; then
  if command -v nvcc >/dev/null 2>&1; then
    echo "[ok] CUDA already installed (nvcc found); skipping CUDA install."
  else
    case "${CUDA_SOURCE}" in
      nvidia)
        if ! install_cuda_from_nvidia_repo; then
          echo "[warn] NVIDIA repo install failed; falling back to Ubuntu package."
          install_cuda_from_ubuntu_repo
        fi
        ;;
      ubuntu)
        install_cuda_from_ubuntu_repo
        ;;
      *)
        echo "[warn] Unknown CUDA_SOURCE='${CUDA_SOURCE}'; skipping CUDA install."
        ;;
    esac
  fi

  # Post-check
  if command -v nvcc >/dev/null 2>&1; then
    echo "[ok] CUDA Toolkit installed: $(nvcc --version | tr -s ' ' | head -n1)"
  else
    echo "[error] CUDA Toolkit installation appears to have failed." >&2
    exit 1
  fi
else
  echo "[skip] INSTALL_CUDA=false; skipping CUDA Toolkit."
fi

echo "[done] Driver/CUDA setup complete. A reboot may be required for the driver to load."