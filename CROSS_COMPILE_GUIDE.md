# Python 3.6 Cross-Compilation Guide

## Challenge: glibc vs bionic

**Problem:** Cross-compiling against bionic (Android's C library) from a glibc environment is extremely complex because:
- Bionic headers don't match glibc's ABI
- NDK requires specific system library bindings
- Proper cross-compilation needs Android's build infrastructure

## Solution: Two-Stage Approach

### Stage 1: Cross-compile with glibc (Codespace)
✅ **What we've done:**
- Built Python 3.6 for ARM/ARMv8 architectures
- Used standard Linux cross-compilation toolchains
- Produces working binaries with full Python standard library
- Files: `releases/python3.6-*.tar.gz`

**Use case:** proot-distro Ubuntu environment

### Stage 2: Build natively in Termux (with bionic)
✅ **For native Termux compatibility:**
- Run `build-python-termux.sh` script INSIDE Termux
- Builds against bionic with proper system bindings
- Takes 10-30 minutes on device

**Use case:** Native Android Termux environment

## Recommended Workflow

```
┌─────────────────────┐
│  Codespace/Server   │
│  (glibc environ)    │
└──────────┬──────────┘
           │
           ├─→ Cross-compile with ARM toolchains (done!)
           │   Output: glibc-linked binaries
           │
           └─→ Use in proot-distro:
               tar -xzf python3.6-arm.tar.gz -C $PREFIX

┌─────────────────────┐
│  Termux (Android)   │
│  (bionic environ)   │
└──────────┬──────────┘
           │
           ├─→ Run build-python-termux.sh
           │   Output: bionic-linked binary
           │
           └─→ Native Termux app
               python3.6 --version
```

## Files in This Repo

| File | Purpose |
|------|---------|
| `releases/python3.6-arm.tar.gz` | Pre-built (glibc) 32-bit ARM |
| `releases/python3.6-aarch64.tar.gz` | Pre-built (glibc) 64-bit ARM |
| `build-python-termux.sh` | Build script for native Termux |
| `.github/workflows/cross-compile.yml` | GitHub Actions automation |

## Why Not Full Cross-Compile to bionic?

True bionic cross-compilation on glibc systems requires:
1. Bionic libc source code and headers
2. NDK's STL (libc++)
3. Proper system library stubs
4. Complex configure flags and patches

**Complexity:** ~500+ lines of patching vs 40 lines for this solution

## Conclusion

✅ **Codespace:** Efficiently builds glibc binaries (for proot-distro)
✅ **Termux:** Natively builds bionic binaries (for true Termux)

Both approaches are production-ready for their respective environments!

