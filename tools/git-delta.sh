#!/usr/bin/env bash
tool_name() { echo "git-delta"; }
tool_check() { command_exists delta; }
tool_install() {
    if is_mac; then
        ensure_brew && brew install git-delta
    elif is_linux; then
        github_install_deb "dandavison/delta" "amd64\\.deb"
    fi
}
tool_status() { std_status "git-delta" "delta"; }
