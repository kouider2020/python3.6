#!/bin/bash
# Run this script INSIDE Termux to build Python 3.6 for bionic

set -e

echo "=== Python 3.6 Native Build for Termux ==="
echo "Building Python 3.6.15 with Termux bionic libc"
echo ""

ARCH=$(uname -m)
echo "Detected architecture: $ARCH"

# Install dependencies
echo "Installing build dependencies..."
apt update > /dev/null 2>&1 || true
apt install -y build-essential libffi-dev libssl-dev libncursesw5-dev libgdbm-dev \
  libc6-dev zlib1g-dev libsqlite3-dev tk-dev libbz2-dev liblzma-dev > /dev/null 2>&1 || true

# Download Python 3.6.15
cd /tmp
[ -d Python-3.6.15 ] || {
  echo "Downloading Python 3.6.15..."
  wget -q https://www.python.org/ftp/python/3.6.15/Python-3.6.15.tar.xz
  tar -xf Python-3.6.15.tar.xz
}

cd Python-3.6.15

echo "Configuring..."
./configure --prefix=$PREFIX > /dev/null 2>&1

echo "Compiling (this takes 10-30 minutes)..."
make -j$(nproc) > /dev/null 2>&1 || make -j1

echo "Installing..."
make install > /dev/null 2>&1

echo ""
echo "✓ Python 3.6 built successfully for Termux!"
$PREFIX/bin/python3.6 --version
