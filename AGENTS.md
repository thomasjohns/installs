# AGENTS.md

## Project Overview

This repository contains an idempotent developer tool installer for macOS and Linux. It installs CLI tools, language toolchains, and developer utilities, skipping anything already present.

## Architecture

- `install.sh` — Main entry point. Runs all or specific tool modules. Supports `--upgrade` to re-install existing tools.
- `status.sh` — Reports installation status (version, path) for all or specific tools.
- `lib/common.sh` — Shared helpers: OS detection, logging, package install wrappers (`pkg_install`, `cargo_install`, `npm_install_global`, `uv_tool_install`, `github_install_deb`, `github_install_tar`), and status formatting (`std_status`, `print_status`).
- `tools/*.sh` — One file per tool. Each implements four functions: `tool_name`, `tool_check`, `tool_install`, `tool_status`.

## Key Conventions

- **Idempotency**: `tool_check` returns 0 if the tool is already installed. `install.sh` skips tools that pass this check (unless `--upgrade` is set).
- **Install order**: Files prefixed with `00-` through `05-` are foundation tools (rustup, go, nvm, node, uv, python) that install before alphabetically-ordered tools. Other tools depend on these (e.g., cargo-installed tools need rustup, npm packages need node).
- **Platform handling**: Each tool's `tool_install` uses `is_mac` / `is_linux` to choose the right install method. macOS uses Homebrew; Linux uses apt, direct downloads, or language-specific installers.
- **Tool lookup**: When running `./install.sh toolname`, the script finds `tools/toolname.sh` or `tools/NN-toolname.sh` (numeric prefix).

## Adding a New Tool

Create `tools/mytool.sh` implementing `tool_name`, `tool_check`, `tool_install`, and `tool_status`. Use helpers from `lib/common.sh` — see the README for the full helper reference. Most simple tools follow this pattern:

```bash
#!/usr/bin/env bash
tool_name() { echo "mytool"; }
tool_check() { command_exists mytool; }
tool_install() { pkg_install "mytool" "mytool"; }
tool_status() { std_status "mytool" "mytool"; }
```

If the tool must install before others, use a numeric prefix (e.g., `06-mytool.sh`).

## Common Pitfalls

- **GLIBC compatibility**: Pre-built binaries from GitHub releases may require a newer glibc than the target system. Prefer PPA, AppImage extraction, or cargo/go install when targeting older distributions.
- **Binary name mismatches**: Some apt packages install under different names (e.g., `fd-find` installs `fdfind`, `bat` installs `batcat` on older Ubuntu). Handle both in `tool_check` and `tool_status`.
- **`set -e` in scripts**: Version commands that exit non-zero (e.g., `dig --version`) will abort the script. The `std_status` helper uses `|| true` to guard against this.
- **Variable shadowing**: `lib/common.sh` uses `COMMON_DIR` instead of `SCRIPT_DIR` to avoid overwriting the caller's `SCRIPT_DIR` when sourced.
- **Shell state between tools**: Tool files are sourced sequentially into the same shell, so functions from one tool overwrite the previous. This is intentional. Tools that need a prerequisite in PATH (e.g., node needs nvm) should call `load_nvm` / `load_cargo` themselves.

## Testing Changes

```bash
# Check a specific tool's status
./status.sh mytool

# Test install (will skip if already present)
./install.sh mytool

# Force re-install
./install.sh -u mytool
```
