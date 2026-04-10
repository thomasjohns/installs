#!/usr/bin/env bash
tool_name() { echo "fzf"; }
tool_check() { command_exists fzf; }
tool_install() { pkg_install "fzf" "fzf"; }
tool_status() { std_status "fzf" "fzf"; }
