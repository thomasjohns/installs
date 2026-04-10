#!/usr/bin/env bash
tool_name() { echo "markitdown"; }
tool_check() { command_exists markitdown; }
tool_install() { uv_tool_install markitdown; }
tool_status() { std_status "markitdown" "markitdown"; }
