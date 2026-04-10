#!/usr/bin/env bash
tool_name() { echo "lazygit"; }
tool_check() { command_exists lazygit; }
tool_install() {
    if is_mac; then
        ensure_brew && brew install lazygit
    elif is_linux; then
        github_install_tar "jesseduffield/lazygit" "Linux_x86_64" "lazygit"
    fi
}
tool_status() { std_status "lazygit" "lazygit"; }
