#!/usr/bin/env bash
tool_name() { echo "ripgrep"; }
tool_check() { command_exists rg; }
tool_install() { pkg_install "ripgrep" "ripgrep"; }
tool_status() { std_status "ripgrep" "rg"; }
