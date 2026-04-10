#!/usr/bin/env bash
tool_name() { echo "rustup"; }
tool_check() { command_exists rustup; }
tool_install() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    load_cargo
}
tool_status() { std_status "rustup" "rustup"; }
