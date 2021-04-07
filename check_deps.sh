#!/usr/bin/env bash

function check_availability() {
    if ! hash "$1" > /dev/null 2>&1; then
        echo "Command not found: $1. Aborting..."
        exit 1
    fi
}

check_availability stow
check_availability curl
check_availability bat
check_availability fzf
check_availability rg
check_availability node

echo "All availabilities met, you can now open vim and run :PlugInstall"
