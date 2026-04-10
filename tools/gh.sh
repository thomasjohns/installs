#!/usr/bin/env bash
tool_name() { echo "gh"; }
tool_check() { command_exists gh; }
tool_install() {
    if is_mac; then
        ensure_brew && brew install gh
    elif is_linux; then
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
            | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
            | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
        sudo apt-get update -qq && sudo apt-get install -y gh
    fi
}
tool_status() { std_status "gh" "gh"; }
