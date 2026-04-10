#!/usr/bin/env bash
tool_name() { echo "pi-mono"; }
tool_check() { command_exists pi; }
tool_install() { npm_install_global "@mariozechner/pi-coding-agent"; }
tool_status() { std_status "pi-mono" "pi"; }
