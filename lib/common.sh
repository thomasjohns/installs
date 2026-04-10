#!/usr/bin/env bash

# Shared helpers for the install system

COMMON_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$COMMON_DIR/.." && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}[INFO]${NC} $*"; }
log_success() { echo -e "${GREEN}[OK]${NC} $*"; }
log_skip()    { echo -e "${YELLOW}[SKIP]${NC} $*"; }
log_error()   { echo -e "${RED}[ERROR]${NC} $*" >&2; }

is_mac()   { [[ "$(uname -s)" == "Darwin" ]]; }
is_linux() { [[ "$(uname -s)" == "Linux" ]]; }

command_exists() { command -v "$1" >/dev/null 2>&1; }

get_arch() {
    local arch
    arch="$(uname -m)"
    case "$arch" in
        x86_64|amd64) echo "amd64" ;;
        aarch64|arm64) echo "arm64" ;;
        *) echo "$arch" ;;
    esac
}

# Print a formatted status row
print_status() {
    local name="$1"
    local status="$2"
    local version="${3:-}"
    local path="${4:-}"
    if [[ "$status" == "installed" ]]; then
        printf "  %-20s ${GREEN}%-15s${NC} %-25s %s\n" "$name" "$status" "$version" "$path"
    else
        printf "  %-20s ${RED}%-15s${NC}\n" "$name" "not installed"
    fi
}

# Standard status check — covers most tools
std_status() {
    local name="$1"
    local cmd="$2"
    local version_flag="${3:---version}"
    if command_exists "$cmd"; then
        local version
        version="$("$cmd" $version_flag 2>/dev/null | head -1 || true)"
        print_status "$name" "installed" "$version" "$(command -v "$cmd")"
    else
        print_status "$name" "not installed"
    fi
}

# Ensure Homebrew is available (macOS)
ensure_brew() {
    if is_mac && ! command_exists brew; then
        log_error "Homebrew required but not found. Install it first: https://brew.sh"
        return 1
    fi
}

# Load NVM into current shell
load_nvm() {
    export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
    [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
}

# Load cargo into current shell
load_cargo() {
    [[ -s "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
}

# Install via apt (Linux) or brew (Mac)
pkg_install() {
    local apt_pkg="$1"
    local brew_pkg="${2:-$apt_pkg}"
    if is_mac; then
        ensure_brew && brew install "$brew_pkg"
    elif is_linux; then
        sudo apt-get update -qq && sudo apt-get install -y "$apt_pkg"
    fi
}

# Install a crate via cargo
cargo_install() {
    local crate="$1"
    load_cargo
    if ! command_exists cargo; then
        log_error "cargo not found. Install rustup first."
        return 1
    fi
    cargo install "$crate"
}

# Install a global npm package
npm_install_global() {
    local pkg="$1"
    load_nvm
    if ! command_exists npm; then
        log_error "npm not found. Install node first."
        return 1
    fi
    npm install -g "$pkg"
}

# Install a Python tool via uv
uv_tool_install() {
    local pkg="$1"
    if ! command_exists uv; then
        log_error "uv not found. Install uv first."
        return 1
    fi
    uv tool install "$pkg"
}

# Download and install a .deb from a GitHub release
github_install_deb() {
    local repo="$1"
    local pattern="$2"
    local url
    url="$(curl -fsSL "https://api.github.com/repos/${repo}/releases/latest" \
        | grep "browser_download_url.*${pattern}" | head -1 | cut -d '"' -f 4)"
    if [[ -z "$url" ]]; then
        log_error "Could not find release for $repo matching $pattern"
        return 1
    fi
    local tmp
    tmp="$(mktemp -d)"
    curl -fsSL "$url" -o "$tmp/pkg.deb"
    sudo dpkg -i "$tmp/pkg.deb"
    rm -rf "$tmp"
}

# Download and install a binary from a GitHub release tarball
github_install_tar() {
    local repo="$1"
    local pattern="$2"
    local binary="$3"
    local url
    url="$(curl -fsSL "https://api.github.com/repos/${repo}/releases/latest" \
        | grep "browser_download_url.*${pattern}" | head -1 | cut -d '"' -f 4)"
    if [[ -z "$url" ]]; then
        log_error "Could not find release for $repo matching $pattern"
        return 1
    fi
    local tmp
    tmp="$(mktemp -d)"
    curl -fsSL "$url" -o "$tmp/archive.tar.gz"
    tar xzf "$tmp/archive.tar.gz" -C "$tmp"
    local bin_path
    bin_path="$(find "$tmp" -name "$binary" -type f -executable 2>/dev/null | head -1)"
    if [[ -z "$bin_path" ]]; then
        bin_path="$(find "$tmp" -name "$binary" -type f | head -1)"
    fi
    if [[ -z "$bin_path" ]]; then
        log_error "Binary $binary not found in archive from $repo"
        rm -rf "$tmp"
        return 1
    fi
    sudo install -m 755 "$bin_path" /usr/local/bin/"$binary"
    rm -rf "$tmp"
}
