#!/usr/bin/env bash
tool_name() { echo "bun"; }
tool_check() { command_exists bun; }
tool_install() {
    curl -fsSL https://bun.sh/install | bash
    export PATH="$HOME/.bun/bin:$PATH"
}
tool_status() { std_status "bun" "bun"; }
