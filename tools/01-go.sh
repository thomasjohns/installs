#!/usr/bin/env bash
tool_name() { echo "go"; }
tool_check() { command_exists go; }
tool_install() {
    if is_mac; then
        ensure_brew && brew install go
    elif is_linux; then
        local version
        version="$(curl -fsSL 'https://go.dev/VERSION?m=text' | head -1)"
        local arch
        arch="$(get_arch)"
        curl -fsSL "https://go.dev/dl/${version}.linux-${arch}.tar.gz" -o /tmp/go.tar.gz
        sudo rm -rf /usr/local/go
        sudo tar -C /usr/local -xzf /tmp/go.tar.gz
        rm /tmp/go.tar.gz
        export PATH="/usr/local/go/bin:$PATH"
    fi
}
tool_status() { std_status "go" "go" "version"; }
