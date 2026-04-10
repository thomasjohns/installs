#!/usr/bin/env bash
tool_name() { echo "kubectx"; }
tool_check() { command_exists kubectx; }
tool_install() {
    if is_mac; then
        ensure_brew && brew install kubectx
    elif is_linux; then
        github_install_tar "ahmetb/kubectx" "kubectx.*linux_x86_64" "kubectx"
        github_install_tar "ahmetb/kubectx" "kubens.*linux_x86_64" "kubens"
    fi
}
tool_status() { std_status "kubectx" "kubectx"; }
