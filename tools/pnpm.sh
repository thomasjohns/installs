#!/usr/bin/env bash
tool_name() { echo "pnpm"; }
tool_check() { command_exists pnpm; }
tool_install() {
    load_nvm
    if command_exists npm; then
        npm install -g pnpm
    else
        curl -fsSL https://get.pnpm.io/install.sh | sh -
    fi
}
tool_status() { std_status "pnpm" "pnpm"; }
