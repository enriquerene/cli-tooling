#!/usr/bin/bash
source $LOCAL/bin/messages-template.sh

PROGRAM_NAME="rename"
USAGE="$PROGRAM_NAME <OLD_FILE> <NEW_NAME>"
EXAMPLES="$PROGRAM_NAME /some/full/path/file.ext newname.xxx\n\tThis will result in a new file /some/full/path/newname.xxx replacing /some/full/path/file.ext. No need to repeat all fullpath. This works for relative paths also."
INSTRUCTIONS=$(GET_USAGE_INSTRUCTIONS "$USAGE" "$EXAMPLES")

if [ "$#" -lt 2 ]; then
    ERROR_MESSAGE 'Too few arguments. Two arguments required.' "$INSTRUCTIONS"
fi

if [ "$#" -gt 2 ]; then
    ERROR_MESSAGE 'Too many arguments. Only two arguments required.' "$INSTRUCTIONS"
fi

if [ ! -f "$1" ]; then
    ERROR_MESSAGE "No such file $1" "$INSTRUCTIONS"
fi

if [ "$(echo $2 | grep '/')" != "" ]; then
    ERROR_MESSAGE 'Do not use relative or full path to the new file name. Use only file basename. See instructions of usage bellow' "$INSTRUCTIONS"
fi

cp "$1" "$(dirname $1)/$2" && rm "$1"
