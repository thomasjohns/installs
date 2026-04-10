#!/usr/bin/env bash
tool_name() { echo "node"; }
tool_check() {
    load_nvm
    command_exists node
}
tool_install() {
    load_nvm
    if ! command_exists nvm; then
        log_error "nvm not found. Install nvm first."
        return 1
    fi
    nvm install node
}
tool_status() {
    load_nvm
    std_status "node" "node"
}
