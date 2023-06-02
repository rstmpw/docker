#!/bin/sh

if [ ! -f "$1" ]; then
    echo "Script $1 not found"
    exit 2
fi

php -f "$@"