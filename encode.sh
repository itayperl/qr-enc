#!/bin/bash

set -e

if [ ! -f "$1" ]; then
    echo "Usage: $0 input-filename [output-filename]"
    echo "input-filename - the file to encode"
    echo "output-filename - the resulting pdf file [out.pdf]"
    exit
fi

filename="$1"
output="${2:-out.pdf}"

tempdir=$(mktemp -d)
trap "rm -rf \"$tempdir\"" EXIT

# qrencode doesn't really support binary data.
base64 "$filename" | split -a 3 -b 1500 - "$tempdir/part_"
for i in "$tempdir"/part_*; do 
    part_id=$(echo "$i" | cut -d_ -f2)
    echo "@$part_id:" | cat - "$i" | qrencode -l Q -o "$i.png"
done

montage -geometry +0+0 -tile 2x3 "$tempdir"/part_*.png "$output"
mogrify -extent 110%x110% -gravity center "$output"
