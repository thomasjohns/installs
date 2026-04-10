#!/usr/bin/env bash
tool_name() { echo "duf"; }
tool_check() { command_exists duf; }
tool_install() {
    if is_mac; then
        ensure_brew && brew install duf
    elif is_linux; then
        github_install_deb "muesli/duf" "linux_amd64.deb"
    fi
}
tool_status() { std_status "duf" "duf"; }
