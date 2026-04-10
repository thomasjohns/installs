#!/usr/bin/env bash
tool_name() { echo "procs"; }
tool_check() { command_exists procs; }
tool_install() {
    if is_mac; then
        ensure_brew && brew install procs
    elif is_linux; then
        cargo_install procs
    fi
}
tool_status() { std_status "procs" "procs"; }
