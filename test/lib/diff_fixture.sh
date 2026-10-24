#!/usr/bin/env bash

# Provision a new fixture with the selected product's working-file format.
# Historical release binaries require raw ext4; current binaries own their DIFF
# header/bitmap layout. Never fall back after a current-format creation error.
create_diff_fixture() { # sandbox-ctl, new path, logical size, ext4|none
    local binary="$1" output="$2" size="$3" filesystem="$4" help
    case "$filesystem" in ext4|none) ;; *) echo "invalid fixture filesystem: $filesystem" >&2; return 2 ;; esac
    if [ -e "$output" ] || [ -L "$output" ]; then
        echo "DIFF fixture already exists: $output" >&2
        return 1
    fi
    help="$("$binary" --help)" || return
    if grep -Fq 'sandbox-ctl diff create' <<<"$help"; then
        "$binary" diff create --output "$output" --size "$size" --filesystem "$filesystem"
    else
        (set -o noclobber; : >"$output") || return
        truncate -s "$size" "$output" || return
        if [ "$filesystem" = ext4 ]; then
            mkfs.ext4 -q -F -b 4096 -O ^has_journal -E lazy_itable_init=0,lazy_journal_init=0 "$output"
        fi
    fi
}
