#!/usr/bin/env bash
tool_name() { echo "fastmod"; }
tool_check() { command_exists fastmod; }
tool_install() {
    if is_mac; then
        ensure_brew && brew install fastmod
    elif is_linux; then
        cargo_install fastmod
    fi
}
tool_status() { std_status "fastmod" "fastmod"; }
