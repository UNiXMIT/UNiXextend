#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <pattern> <directory>"
    exit 1
fi

pattern="$1"
directory="$2"

if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' not found."
    exit 1
fi

cd "$directory" || exit

for file in *.so; do
    if [ ! -d "$file" ]; then
        result=$(nm -D "$file" | grep "$pattern")
        if [ -n "$result" ]; then
            echo "Pattern '$pattern' found in file: $file"
            echo "$result"
        fi
    fi
done
