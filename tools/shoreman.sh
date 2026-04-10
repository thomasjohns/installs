#!/usr/bin/env bash
tool_name() { echo "shoreman"; }
tool_check() { command_exists shoreman; }
tool_install() {
    curl -fsSL https://github.com/chrismytton/shoreman/raw/master/shoreman.sh -o /tmp/shoreman
    sudo install -m 755 /tmp/shoreman /usr/local/bin/shoreman
    rm /tmp/shoreman
}
tool_status() { std_status "shoreman" "shoreman"; }
