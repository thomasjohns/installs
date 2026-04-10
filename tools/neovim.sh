#!/usr/bin/env bash
tool_name() { echo "neovim"; }
tool_check() { command_exists nvim; }
tool_install() {
    if is_mac; then
        ensure_brew && brew install neovim
    elif is_linux; then
        # Build from source to get a recent version on older glibc systems
        sudo apt-get update -qq
        sudo apt-get install -y ninja-build gettext cmake unzip curl build-essential
        local build_dir
        build_dir="$(mktemp -d)"
        git clone --depth 1 --branch stable https://github.com/neovim/neovim.git "$build_dir"
        cd "$build_dir"
        # Prefer system ninja over any broken Python wrappers in ~/.local/bin
        export PATH="/usr/bin:$PATH"
        make CMAKE_BUILD_TYPE=Release
        sudo make install
        rm -rf "$build_dir"
    fi
}
tool_status() { std_status "neovim" "nvim"; }
