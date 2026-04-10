#!/usr/bin/env bash
tool_name() { echo "kubectl"; }
tool_check() { command_exists kubectl; }
tool_install() {
    if is_mac; then
        ensure_brew && brew install kubectl
    elif is_linux; then
        local version
        version="$(curl -fsSL https://dl.k8s.io/release/stable.txt)"
        curl -fsSL "https://dl.k8s.io/release/${version}/bin/linux/amd64/kubectl" -o /tmp/kubectl
        sudo install -m 755 /tmp/kubectl /usr/local/bin/kubectl
        rm /tmp/kubectl
    fi
}
tool_status() { std_status "kubectl" "kubectl" "version --client"; }
