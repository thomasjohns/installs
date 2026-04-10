#!/usr/bin/env bash
tool_name() { echo "uv"; }
tool_check() { command_exists uv; }
tool_install() {
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
}
tool_status() { std_status "uv" "uv"; }
