#!/usr/bin/env bash
tool_name() { echo "zoxide"; }
tool_check() { command_exists zoxide; }
tool_install() {
    if is_mac; then
        ensure_brew && brew install zoxide
    elif is_linux; then
        curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    fi
}
tool_status() { std_status "zoxide" "zoxide"; }
