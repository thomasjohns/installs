#!/usr/bin/env bash
tool_name() { echo "vscode-cli"; }
tool_check() { command_exists code; }
tool_install() {
    if is_mac; then
        ensure_brew && brew install --cask visual-studio-code
    elif is_linux; then
        curl -fsSL "https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64" \
            -o /tmp/vscode-cli.tar.gz
        sudo tar xzf /tmp/vscode-cli.tar.gz -C /usr/local/bin/
        rm /tmp/vscode-cli.tar.gz
    fi
}
tool_status() { std_status "vscode-cli" "code"; }
