#!/usr/bin/env bash
tool_name() { echo "tmux"; }
tool_check() { command_exists tmux; }
tool_install() { pkg_install "tmux" "tmux"; }
tool_status() { std_status "tmux" "tmux"; }
