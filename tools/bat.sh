#!/usr/bin/env bash
tool_name() { echo "bat"; }
tool_check() { command_exists bat || command_exists batcat; }
tool_install() { pkg_install "bat" "bat"; }
tool_status() {
    if command_exists bat; then
        std_status "bat" "bat"
    elif command_exists batcat; then
        std_status "bat" "batcat"
    else
        print_status "bat" "not installed"
    fi
}
