#!/usr/bin/env bash
tool_name() { echo "nvm"; }
tool_check() {
    export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
    [[ -s "$NVM_DIR/nvm.sh" ]]
}
tool_install() {
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    load_nvm
}
tool_status() {
    if tool_check; then
        load_nvm
        local version
        version="$(nvm --version 2>/dev/null)"
        print_status "nvm" "installed" "$version" "${NVM_DIR:-$HOME/.nvm}"
    else
        print_status "nvm" "not installed"
    fi
}
