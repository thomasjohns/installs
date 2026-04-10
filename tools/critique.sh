#!/usr/bin/env bash
tool_name() { echo "critique"; }
tool_check() { command_exists critique; }
tool_install() {
    if ! command_exists bun; then
        log_error "bun required to install critique. Install bun first."
        return 1
    fi
    bun install -g critique
}
tool_status() { std_status "critique" "critique"; }
