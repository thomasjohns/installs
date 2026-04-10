#!/usr/bin/env bash
tool_name() { echo "eza"; }
tool_check() { command_exists eza; }
tool_install() {
    if is_mac; then
        ensure_brew && brew install eza
    elif is_linux; then
        cargo_install eza
    fi
}
tool_status() { std_status "eza" "eza"; }
