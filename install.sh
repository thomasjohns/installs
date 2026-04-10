#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/common.sh"

TOOLS_DIR="$SCRIPT_DIR/tools"
UPGRADE=false

usage() {
    echo "Usage: ./install.sh [-u|--upgrade] [tool ...]"
    echo ""
    echo "  -u, --upgrade   Re-run install for tools even if already installed"
    echo ""
    echo "  With no tool arguments, all tools are processed."
    echo "  With tool arguments, only those tools are processed."
}

# Parse flags
while [[ $# -gt 0 ]]; do
    case "$1" in
        -u|--upgrade) UPGRADE=true; shift ;;
        -h|--help) usage; exit 0 ;;
        -*) log_error "Unknown option: $1"; usage; exit 1 ;;
        *) break ;;
    esac
done

find_tool_file() {
    local tool="$1"
    for f in "$TOOLS_DIR"/${tool}.sh "$TOOLS_DIR"/[0-9][0-9]-${tool}.sh; do
        if [[ -f "$f" ]]; then
            echo "$f"
            return 0
        fi
    done
    return 1
}

install_tool() {
    local tool_file="$1"
    source "$tool_file"
    local name
    name="$(tool_name)"
    if tool_check && ! $UPGRADE; then
        log_skip "$name already installed"
    else
        if $UPGRADE && tool_check; then
            log_info "Upgrading $name..."
        else
            log_info "Installing $name..."
        fi
        if tool_install; then
            log_success "$name installed"
        else
            log_error "Failed to install $name"
        fi
    fi
}

if [[ $# -gt 0 ]]; then
    for tool in "$@"; do
        tool_file="$(find_tool_file "$tool")" || {
            log_error "Unknown tool: $tool"
            continue
        }
        install_tool "$tool_file"
    done
else
    for tool_file in "$TOOLS_DIR"/*.sh; do
        install_tool "$tool_file"
    done
fi
