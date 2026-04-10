#!/usr/bin/env bash
tool_name() { echo "tuicr"; }
tool_check() { command_exists tuicr; }
tool_install() {
    if is_mac; then
        ensure_brew && brew install agavra/tap/tuicr
    elif is_linux; then
        cargo_install tuicr
    fi
}
tool_status() { std_status "tuicr" "tuicr"; }
