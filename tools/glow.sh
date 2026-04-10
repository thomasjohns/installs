#!/usr/bin/env bash
tool_name() { echo "glow"; }
tool_check() { command_exists glow; }
tool_install() {
    if is_mac; then
        ensure_brew && brew install glow
    elif is_linux; then
        github_install_tar "charmbracelet/glow" "Linux_x86_64.tar.gz" "glow"
    fi
}
tool_status() { std_status "glow" "glow"; }
