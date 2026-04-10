#!/usr/bin/env bash
tool_name() { echo "just"; }
tool_check() { command_exists just; }
tool_install() {
    if is_mac; then
        ensure_brew && brew install just
    elif is_linux; then
        cargo_install just
    fi
}
tool_status() { std_status "just" "just"; }
