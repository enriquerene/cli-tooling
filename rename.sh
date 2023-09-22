#!/usr/bin/bash

function GET_USAGE_INSTRUCTIONS () {
    PROGRAM_NAME=$(echo $0 | rev | cut -d'/' -f1 | rev)
    echo $PROGRAM_NAME': CLI tool for rename a file. Only the filename will be changed even a full path is given.'
    echo ''
    echo 'Usage: '$PROGRAM_NAME' <OLD_FILE> <NEW_NAME>'
    echo 'Example:'
    echo -e "\t$PROGRAM_NAME /some/full/path/file.ext newname.xxx"
    echo -e "\tThis will result in a new file /some/full/path/newname.xxx replacing /some/full/path/file.ext. No need to repeat all fullpath. This works for relative paths also."
}

function ERROR_MESSAGE () {
    echo "ERROR: $1"
    echo ''
    GET_USAGE_INSTRUCTIONS
    exit 1
}

if [ "$#" -lt 2 ]; then
    ERROR_MESSAGE 'Too few arguments. Two arguments required.'
fi

if [ "$#" -gt 2 ]; then
    ERROR_MESSAGE 'Too many arguments. Only two arguments required.'
fi

if [ ! -f "$1" ]; then
    ERROR_MESSAGE "No such file $1"
fi

if [ "$(echo $2 | grep '/')" != "" ]; then
    ERROR_MESSAGE 'Do not use relative or full path to the new file name. Use only file basename. See instructions of usage bellow'
fi

cp "$1" "$(dirname $1)/$2" && rm "$1"
