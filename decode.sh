#!/bin/bash

if [ ! -f "$1" ]; then
    echo "Usage: $0 image-files..."
    echo "Spits the decoded file to stdout."
    exit
fi

# format: '@' + part id + ':' + base64
ls "$@" | xargs -n 1 zbarimg --raw -q -Sdisable -Sqrcode.enable | tr -d '\n' | tr '@' '\n' | sort | cut -d: -f2 | base64 -d
