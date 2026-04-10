#!/usr/bin/env bash
tool_name() { echo "fd"; }
tool_check() { command_exists fd || command_exists fdfind; }
tool_install() { pkg_install "fd-find" "fd"; }
tool_status() {
    if command_exists fd; then
        std_status "fd" "fd"
    elif command_exists fdfind; then
        std_status "fd" "fdfind"
    else
        print_status "fd" "not installed"
    fi
}
