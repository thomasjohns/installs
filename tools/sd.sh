#!/usr/bin/env bash
tool_name() { echo "sd"; }
tool_check() { command_exists sd; }
tool_install() {
    if is_mac; then
        ensure_brew && brew install sd
    elif is_linux; then
        cargo_install sd
    fi
}
tool_status() { std_status "sd" "sd"; }
