#!/usr/bin/env bash
tool_name() { echo "watchexec"; }
tool_check() { command_exists watchexec; }
tool_install() {
    if is_mac; then
        ensure_brew && brew install watchexec
    elif is_linux; then
        cargo_install watchexec-cli
    fi
}
tool_status() { std_status "watchexec" "watchexec"; }
