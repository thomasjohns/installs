#!/usr/bin/env bash
tool_name() { echo "codex"; }
tool_check() { command_exists codex; }
tool_install() { npm_install_global "@openai/codex"; }
tool_status() { std_status "codex" "codex"; }
