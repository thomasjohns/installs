#!/usr/bin/env bash
tool_name() { echo "cargo"; }
tool_check() { load_cargo; command_exists cargo; }
tool_install() {
    log_info "cargo is installed via rustup"
    if ! command_exists rustup; then
        log_error "Install rustup first"
        return 1
    fi
}
tool_status() { load_cargo; std_status "cargo" "cargo"; }
