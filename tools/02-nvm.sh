#!/usr/bin/env bash
tool_name() { echo "nvm"; }
# nvm is only usable if its loader is in the rc file the interactive shell
# reads. nvm's installer picks that file itself and falls back to ~/.profile
# when ~/.zshrc does not exist yet (typical on a fresh macOS), which zsh never
# reads. So "installed" means: nvm.sh present AND loader in shell_rc_file.
tool_check() {
    export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
    [[ -s "$NVM_DIR/nvm.sh" ]] && shell_rc_has "/nvm.sh"
}
tool_install() {
    local rc
    rc="$(shell_rc_file)"
    # nvm's installer only honors PROFILE if the file already exists
    touch "$rc"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | PROFILE="$rc" bash
    load_nvm
}
tool_status() {
    export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
    if [[ -s "$NVM_DIR/nvm.sh" ]]; then
        load_nvm
        local version
        version="$(nvm --version 2>/dev/null)"
        if ! shell_rc_has "/nvm.sh"; then
            version="$version (not loaded by $(basename "$(shell_rc_file)"))"
        fi
        print_status "nvm" "installed" "$version" "$NVM_DIR"
    else
        print_status "nvm" "not installed"
    fi
}
