#!/usr/bin/env bash
tool_name() { echo "tree"; }
tool_check() { command_exists tree; }
tool_install() { pkg_install "tree" "tree"; }
tool_status() { std_status "tree" "tree"; }
