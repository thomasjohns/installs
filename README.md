# installs

Idempotent developer tool installer for macOS and Linux. Each tool is a self-contained module that knows how to check, install, and report on itself.

## Usage

```bash
# Install all tools
./install.sh

# Install specific tools
./install.sh neovim ripgrep tmux

# Upgrade tools (re-run install even if already present)
./install.sh -u
./install.sh -u neovim ripgrep

# Show status of all tools
./status.sh

# Show status of specific tools
./status.sh gh kubectl node
```

## Project Structure

```
installs/
├── install.sh          # Main installer (selective or all)
├── status.sh           # Status reporter
├── lib/
│   └── common.sh       # Shared helpers (OS detection, logging, install helpers)
└── tools/
    ├── 00-rustup.sh    # Foundation tools (numbered for install order)
    ├── 01-go.sh
    ├── 02-nvm.sh
    ├── 03-node.sh
    ├── 04-uv.sh
    ├── 05-python.sh
    └── *.sh            # All other tools (alphabetical)
```

Foundation tools are numbered (`00-`, `01-`, ...) so they install first when running `./install.sh` with no arguments. Other tools depend on them (e.g., cargo-installed tools need rustup, npm packages need node).

## Tools

| Tool | Description | Mac | Linux |
|------|-------------|-----|-------|
| **rustup** | Rust toolchain manager | rustup.rs | rustup.rs |
| **go** | Go programming language | brew | official tarball |
| **nvm** | Node version manager | curl installer | curl installer |
| **node** | Node.js (latest via nvm) | nvm | nvm |
| **uv** | Python package manager | curl installer | curl installer |
| **python** | Python 3 | uv / brew | uv / apt |
| **bat** | cat with syntax highlighting | brew | apt |
| **bun** | JavaScript runtime | curl installer | curl installer |
| **cargo** | Rust package manager | via rustup | via rustup |
| **claude-code** | Anthropic Claude CLI | npm | npm |
| **codex** | OpenAI Codex CLI | npm | npm |
| **copilot-cli** | GitHub Copilot CLI | npm | npm |
| **critique** | Code review CLI | bun | bun |
| **devtunnel** | Microsoft Dev Tunnels | brew cask | curl installer |
| **difi** | Git diff TUI | brew | go install |
| **dnsutils** | DNS tools (dig, nslookup) | brew (bind) | apt |
| **duf** | Disk usage utility | brew | GitHub .deb |
| **eza** | Modern ls replacement | brew | cargo |
| **expect** | Scripted terminal interactions | brew | apt |
| **fastmod** | Fast codemod tool | brew | cargo |
| **fd** | Fast file finder | brew | apt (fd-find) |
| **fzf** | Fuzzy finder | brew | apt |
| **gcloud** | Google Cloud SDK | brew cask | curl installer |
| **gemini-cli** | Google Gemini CLI | npm | npm |
| **gh** | GitHub CLI | brew | official apt repo |
| **git-delta** | Better git diffs | brew | GitHub .deb |
| **glow** | Markdown renderer | brew | GitHub tarball |
| **jq** | JSON processor | brew | apt |
| **just** | Command runner | brew | cargo |
| **kubectl** | Kubernetes CLI | brew | official binary |
| **kubectx** | Kubernetes context switcher | brew | GitHub tarball |
| **lazygit** | Git TUI | brew | GitHub tarball |
| **markitdown** | Document to markdown converter | uv tool | uv tool |
| **mutagen** | File sync tool | brew | GitHub tarball |
| **neovim** | Text editor | brew | PPA |
| **pi-mono** | Pi coding agent | npm | npm |
| **pnpm** | Fast npm alternative | npm | npm / curl |
| **procps** | Process utilities (ps, top) | brew | apt |
| **procs** | Modern ps replacement | brew | cargo |
| **psql** | PostgreSQL client | brew (libpq) | apt |
| **ripgrep** | Fast grep | brew | apt |
| **rust** | Rust compiler | via rustup | via rustup |
| **sd** | Modern sed alternative | brew | cargo |
| **shoreman** | Procfile runner | curl | curl |
| **tmux** | Terminal multiplexer | brew | apt |
| **tree** | Directory tree viewer | brew | apt |
| **tuicr** | TUI code review | brew tap | cargo |
| **vscode-cli** | VS Code CLI | brew cask | official binary |
| **watchexec** | File watcher / command runner | brew | cargo |
| **yq** | YAML processor | brew | GitHub binary |
| **zoxide** | Smart cd | brew | curl installer |

## Adding a New Tool

Create a file in `tools/` (e.g., `tools/mytool.sh`) implementing four functions:

```bash
#!/usr/bin/env bash
tool_name() { echo "mytool"; }

tool_check() {
    command_exists mytool
}

tool_install() {
    if is_mac; then
        ensure_brew && brew install mytool
    elif is_linux; then
        sudo apt-get update -qq && sudo apt-get install -y mytool
    fi
}

tool_status() {
    std_status "mytool" "mytool"
}
```

### Available helpers (from `lib/common.sh`)

| Helper | Description |
|--------|-------------|
| `is_mac` / `is_linux` | OS detection |
| `command_exists cmd` | Check if a command is on PATH |
| `pkg_install apt_pkg [brew_pkg]` | Install via apt (Linux) or brew (Mac) |
| `cargo_install crate` | Install a Rust crate via cargo |
| `npm_install_global pkg` | Install a global npm package |
| `uv_tool_install pkg` | Install a Python tool via uv |
| `github_install_deb repo pattern` | Install a .deb from GitHub releases |
| `github_install_tar repo pattern binary` | Install a binary from a GitHub release tarball |
| `std_status name cmd [version_flag]` | Print a standard status row |
| `print_status name status [version] [path]` | Print a custom status row |
| `load_nvm` / `load_cargo` | Load version managers into the current shell |
| `ensure_brew` | Error if Homebrew is not installed (macOS) |
| `get_arch` | Returns `amd64` or `arm64` |
| `log_info` / `log_success` / `log_skip` / `log_error` | Colored logging |

## Prerequisites

- **macOS**: [Homebrew](https://brew.sh) must be installed
- **Linux**: apt-based distribution (Debian/Ubuntu). Some tools fall back to cargo or direct downloads.
