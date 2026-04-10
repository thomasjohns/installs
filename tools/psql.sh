#!/usr/bin/env bash
tool_name() { echo "psql"; }
tool_check() { command_exists psql; }
tool_install() {
    if is_mac; then
        ensure_brew && brew install libpq
        brew link --force libpq
    elif is_linux; then
        sudo apt-get update -qq && sudo apt-get install -y postgresql-client
    fi
}
tool_status() { std_status "psql" "psql"; }
