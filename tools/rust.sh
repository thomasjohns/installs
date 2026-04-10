#!/usr/bin/env bash
tool_name() { echo "rust"; }
tool_check() { load_cargo; command_exists rustc; }
tool_install() {
    log_info "rust is installed via rustup"
    if ! command_exists rustup; then
        log_error "Install rustup first"
        return 1
    fi
}
tool_status() { load_cargo; std_status "rust" "rustc"; }
