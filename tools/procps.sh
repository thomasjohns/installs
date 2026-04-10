#!/usr/bin/env bash
tool_name() { echo "procps"; }
tool_check() { command_exists ps; }
tool_install() { pkg_install "procps" "procps"; }
tool_status() { std_status "procps" "ps"; }
