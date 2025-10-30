#!/usr/bin/env zsh
set -euo pipefail

# C/C++ toolchain for Ubuntu: GCC, Clang/LLVM, OpenMP, OpenMPI, and common build tools
# Idempotent and safe for non-interactive runs

sudo apt-get update -y || true

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
	gcc \
	g++ \
	clang \
	clang-format \
	clang-tidy \
	lldb \
	lld \
	llvm \
	llvm-dev \
	libomp-dev \
	libc++-dev \
	libc++abi-dev \
	openmpi-bin \
	libopenmpi-dev \
	cmake \
	ninja-build \
	pkg-config

# Quick sanity outputs (non-fatal if missing)
command -v gcc >/dev/null 2>&1 && gcc --version | head -n1 || true
command -v clang >/dev/null 2>&1 && clang --version | head -n1 || true
command -v mpic++ >/dev/null 2>&1 && mpic++ --showme || true
