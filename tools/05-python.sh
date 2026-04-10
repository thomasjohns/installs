#!/usr/bin/env bash
tool_name() { echo "python"; }
tool_check() { command_exists python3; }
tool_install() {
    if command_exists uv; then
        uv python install
    else
        pkg_install "python3" "python@3"
    fi
}
tool_status() { std_status "python" "python3"; }
