#!/usr/bin/env bash
tool_name() { echo "expect"; }
tool_check() { command_exists expect; }
tool_install() { pkg_install "expect" "expect"; }
tool_status() { std_status "expect" "expect"; }
