#!/usr/bin/env bash
tool_name() { echo "hunk"; }
tool_check() { command_exists hunk; }
tool_install() {
    if is_mac; then
        ensure_brew && brew install hunk
    elif is_linux; then
        # hunk finds its bundled agent skills by walking up from the binary
        # (`hunk skill path`), so keep the whole release payload together under
        # /usr/local/lib/hunk and expose the binary through a symlink. The
        # binary resolves the symlink, so skills still load.
        local arch
        arch="$(get_arch)"
        [[ "$arch" == "amd64" ]] && arch="x64"
        local url
        url="$(curl -fsSL https://api.github.com/repos/modem-dev/hunk/releases/latest \
            | grep "browser_download_url.*hunkdiff-linux-${arch}.tar.gz\"" | head -1 | cut -d '"' -f 4)"
        if [[ -z "$url" ]]; then
            log_error "Could not find a hunk release for linux-${arch}"
            return 1
        fi
        local tmp
        tmp="$(mktemp -d)"
        mkdir -p "$tmp/payload"
        curl -fsSL "$url" -o "$tmp/hunk.tar.gz"
        tar xzf "$tmp/hunk.tar.gz" -C "$tmp/payload" --strip-components=1
        sudo rm -rf /usr/local/lib/hunk
        sudo mkdir -p /usr/local/lib
        sudo cp -R "$tmp/payload" /usr/local/lib/hunk
        sudo chmod 755 /usr/local/lib/hunk/hunk
        sudo ln -sfn /usr/local/lib/hunk/hunk /usr/local/bin/hunk
        rm -rf "$tmp"
    fi
}
tool_status() { std_status "hunk" "hunk"; }
