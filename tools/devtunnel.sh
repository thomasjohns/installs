#!/usr/bin/env bash
tool_name() { echo "devtunnel"; }
tool_check() { command_exists devtunnel; }
tool_install() {
    if is_mac; then
        ensure_brew && brew install --cask devtunnel
    elif is_linux; then
        curl -sL https://aka.ms/DevTunnelCliInstall | bash
    fi
}
tool_status() { std_status "devtunnel" "devtunnel"; }
