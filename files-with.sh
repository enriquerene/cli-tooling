#!/usr/bin/bash
source ./messages-template.sh

USAGE="files-with <regex_pattern> [<directory>[ <grep_around_lines>[ ...]]]\n\ndefault directory for searching is current one."
EXAMPLES=""
INSTRUCTIONS=$(GET_USAGE_INSTRUCTIONS "$USAGE" "$EXAMPLES")

DIRECTORY_LIST=''
PATTERN=''

if [ -z "$1" ]; then
    ERROR_MESSAGE 'No argument provided' "$INSTRUCTIONS"
else
    PATTERN="$1"
fi

if [ -z "$2" ]; then
    DIRECTORY_LIST='.'
else
    DIRECTORY_LIST="$2"
fi

if [ -z "$3" ]; then
    NO_LINES=0
else
    NO_LINES="$3"
fi

for DIR in $DIRECTORY_LIST; do
    for FILE in $(find $DIR -type f -exec grep $PATTERN -l {} \;); do
        if [ "$NO_LINES" = "0" ]; then
            echo $FILE
        else
            echo Ocurrence of $PATTERN in $FILE
            echo '---'
            grep -$NO_LINES $PATTERN $FILE
        fi
    done
done
