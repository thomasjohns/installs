#!/usr/bin/env bash
tool_name() { echo "jq"; }
tool_check() { command_exists jq; }
tool_install() { pkg_install "jq" "jq"; }
tool_status() { std_status "jq" "jq"; }
