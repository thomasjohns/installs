#!/usr/bin/env bash
tool_name() { echo "dnsutils"; }
tool_check() { command_exists dig; }
tool_install() { pkg_install "dnsutils" "bind"; }
tool_status() { std_status "dnsutils" "dig"; }
