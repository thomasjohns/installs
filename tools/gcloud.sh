#!/usr/bin/env bash
tool_name() { echo "gcloud"; }
tool_check() { command_exists gcloud; }
tool_install() {
    if is_mac; then
        ensure_brew && brew install --cask google-cloud-sdk
    elif is_linux; then
        curl -fsSL https://sdk.cloud.google.com | bash -s -- --disable-prompts
        export PATH="$HOME/google-cloud-sdk/bin:$PATH"
    fi
}
tool_status() { std_status "gcloud" "gcloud"; }
