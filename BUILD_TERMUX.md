# Building Python 3.6 for Termux (Native Bionic)

## Problem with Pre-built Binaries

The pre-compiled binaries in `/releases` are built with **glibc** and will only work inside proot-distro, not in native Termux.

**Why?** Termux uses **bionic** (Android's C library), not glibc:
- Pre-built: `interpreter /lib/ld-linux-aarch64.so.1` (glibc)
- Termux needs: `interpreter /lib/ld-android-aarch64.so.1` (bionic)

## Solution: Build Natively in Termux

### Step 1: Prepare Termux
```bash
# Install essential build tools
pkg update
pkg install build-essential clang curl git
```

### Step 2: Run the Build Script
```bash
# Download the build script
curl -O https://raw.githubusercontent.com/kouider2020/python3.6/master/build-python-termux.sh
chmod +x build-python-termux.sh

# Run it
bash build-python-termux.sh
```

**Note:** This takes 10-30 minutes depending on your device.

### Step 3: Verify Installation
```bash
python3.6 --version
python3.6 -c "import sys; print(sys.executable)"
```

## What Gets Built

✓ Python 3.6.15 native binary linked against **bionic**
✓ Full standard library (1600+ modules)
✓ Optimized for ARM architecture
✓ Installed in `$PREFIX` (usually `/data/data/com.termux/files/usr`)

## Troubleshooting

**"command not found: python3.6"**
- Check installation: `ls $PREFIX/bin/python3.6`
- Ensure PATH includes prefix: `echo $PATH`

**Build fails on specific modules**
- Some C extensions (like `_tkinter`, `_curses`) need extra dependencies
- Core Python and most standard library modules will build successfully

**Out of storage**
- Temporary files in `/tmp` use space
- Delete after build: `rm -rf /tmp/Python-3.6.15`

## Architecture-specific Notes

### 32-bit ARM (armv7l)
- Older phones and cheap devices
- Slower compilation but still works

### 64-bit ARM (aarch64)
- Modern Android devices
- Faster, recommended

