#!/usr/bin/env bash
tool_name() { echo "copilot-cli"; }
tool_check() { load_nvm; command_exists copilot; }
tool_install() { npm_install_global "@github/copilot"; }
tool_status() { load_nvm; std_status "copilot-cli" "copilot"; }
