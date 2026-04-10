#!/usr/bin/env bash
tool_name() { echo "mutagen"; }
tool_check() { command_exists mutagen; }
tool_install() {
    if is_mac; then
        ensure_brew && brew install mutagen-io/mutagen/mutagen
    elif is_linux; then
        github_install_tar "mutagen-io/mutagen" "linux_amd64" "mutagen"
    fi
}
tool_status() { std_status "mutagen" "mutagen"; }
