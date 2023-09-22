#!/usr/bin/bash

function GET_USAGE_INSTRUCTIONS () {
    echo "USAGE INSTRUCTIONS"
    echo -e "$1"
    echo ''
    if [ ! -z "$2" ]; then
        echo "EXAMPLES"
        echo -e "$2"
    fi
}

function ERROR_MESSAGE () {
    echo "ERROR: $1"
    echo ''
    echo -e "$2"
    exit 1
}

