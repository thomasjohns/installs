#!/usr/bin/env bash
tool_name() { echo "herdr"; }
tool_check() { command_exists herdr; }
tool_install() {
    # Official installer (same on macOS and Linux). Drops the binary in
    # ~/.local/bin and is what `herdr update` expects. It does not touch rc
    # files, so make sure the interactive shell will find it.
    curl -fsSL https://herdr.dev/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
    if ! shell_rc_has '.local/bin'; then
        printf '\nexport PATH="$HOME/.local/bin:$PATH"\n' >> "$(shell_rc_file)"
    fi
}
tool_status() { std_status "herdr" "herdr"; }
