#!/usr/bin/env bash
tool_name() { echo "gemini-cli"; }
tool_check() { command_exists gemini; }
tool_install() { npm_install_global "@google/gemini-cli"; }
tool_status() { std_status "gemini-cli" "gemini"; }
