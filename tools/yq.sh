#!/usr/bin/env bash
tool_name() { echo "yq"; }
tool_check() { command_exists yq; }
tool_install() {
    if is_mac; then
        ensure_brew && brew install yq
    elif is_linux; then
        local arch
        arch="$(get_arch)"
        local url
        url="$(curl -fsSL https://api.github.com/repos/mikefarah/yq/releases/latest \
            | grep "browser_download_url.*linux_${arch}\"" | head -1 | cut -d '"' -f 4)"
        curl -fsSL "$url" -o /tmp/yq
        sudo install -m 755 /tmp/yq /usr/local/bin/yq
        rm /tmp/yq
    fi
}
tool_status() { std_status "yq" "yq"; }
