#!/bin/sh

if [ "$1" = "arm" ]; then
    npx scribble "$2" --output-mode files --instrumentation-metadata-file .scribble-meta.json --arm
elif [ "$1" = "disarm" ]; then
    npx scribble "$2" --output-mode files --instrumentation-metadata-file .scribble-meta.json --disarm
else
    echo "Usage: scribble-util.sh <arm|disarm> <file-path>"
    exit 1
fi
