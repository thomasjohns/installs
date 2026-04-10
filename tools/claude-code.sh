#!/usr/bin/env bash
tool_name() { echo "claude-code"; }
tool_check() { command_exists claude; }
tool_install() { npm_install_global "@anthropic-ai/claude-code"; }
tool_status() { std_status "claude-code" "claude"; }
