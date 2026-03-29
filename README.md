# Python 3.6 Cross-Compilation for Termux/ARM

This repository automatically cross-compiles Python 3.6 for ARM architectures (32-bit and 64-bit) using GitHub Actions.

## Features

- **Automatic cross-compilation** for `arm` and `aarch64` architectures
- **Runs on GitHub Actions** (no need for local compilation)
- **Pre-built binaries** available as artifacts

## How to use

### Option 1: Download from Artifacts (Recommended)

1. Go to the **Actions** tab
2. Click on the latest successful workflow run
3. Download the artifact for your architecture:
   - `python-3.6-arm` for 32-bit ARM
   - `python-3.6-aarch64` for 64-bit ARM (ARMv8)

### Option 2: Trigger a build

1. Go to **Actions** tab
2. Click on "Cross-compile Python 3.6 for Termux/ARM"
3. Click **"Run workflow"**
4. Wait for the build to complete
5. Download artifacts

### Option 3: Create a Release

Tag a commit to automatically build and create a GitHub Release:

```bash
git tag v3.6.15
git push origin v3.6.15
```

## Installation in Termux

After downloading the tarball:

```bash
# Extract to Termux home
tar -xzf python3.6-*.tar.gz -C $HOME

# Add to PATH
echo 'export PATH=$HOME/usr/local/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# Verify
python3.6 --version
```

## Build Details

- **Python Version**: 3.6.15 (latest in 3.6 branch)
- **Architectures**: ARM (32-bit) and ARMv8 (64-bit)
- **Includes**: OpenSSL, zlib, sqlite3, and other standard Python modules
- **IPv6**: Disabled (for Termux compatibility)

## License

Python is licensed under the Python Software Foundation License.
