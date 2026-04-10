#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/common.sh"

TOOLS_DIR="$SCRIPT_DIR/tools"

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

echo ""
echo -e "${BOLD}Developer Tools Status${NC}"
echo ""
printf "  %-20s %-15s %-25s %s\n" "Tool" "Status" "Version" "Path"
printf "  %-20s %-15s %-25s %s\n" "────" "──────" "───────" "────"

if [[ $# -gt 0 ]]; then
    for tool in "$@"; do
        tool_file="$(find_tool_file "$tool")" || {
            log_error "Unknown tool: $tool"
            continue
        }
        source "$tool_file"
        tool_status
    done
else
    for tool_file in "$TOOLS_DIR"/*.sh; do
        source "$tool_file"
        tool_status
    done
fi

echo ""
