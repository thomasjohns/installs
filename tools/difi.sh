#!/usr/bin/env bash
tool_name() { echo "difi"; }
tool_check() { command_exists difi; }
tool_install() {
    if is_mac; then
        ensure_brew && brew install difi
    elif is_linux; then
        if command_exists go; then
            go install github.com/xguot/difi/cmd/difi@latest
        else
            log_error "go required to install difi on Linux. Install go first."
            return 1
        fi
    fi
}
tool_status() { std_status "difi" "difi"; }
