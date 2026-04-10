#!/usr/bin/env bash
tool_name() { echo "neovim"; }
tool_check() { command_exists nvim; }
tool_install() {
    if is_mac; then
        ensure_brew && brew install neovim
    elif is_linux; then
        # Use the neovim PPA for a recent version compatible with older glibc
        if command_exists add-apt-repository; then
            sudo add-apt-repository -y ppa:neovim-ppa/unstable
            sudo apt-get update -qq
            sudo apt-get install -y neovim
        else
            sudo apt-get update -qq
            sudo apt-get install -y software-properties-common
            sudo add-apt-repository -y ppa:neovim-ppa/unstable
            sudo apt-get update -qq
            sudo apt-get install -y neovim
        fi
    fi
}
tool_status() { std_status "neovim" "nvim"; }
