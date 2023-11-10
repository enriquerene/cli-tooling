#!/usr/bin/bash
source $LOCAL/bin/messages-template.sh

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
shift

if [ -n "$(echo $@ | sed 's/--type=.* //' | sed 's/--lines=.* //' | grep '\-\-')" ]; then
    ERROR_MESSAGE 'invalid option provided' "$INSTRUCTIONS"
fi


DIRECTORY_LIST='.'
NO_LINES=0
if [ -z "$(echo $@ | grep '\-\-')" ]; then
    if [ -n "$1" ]; then
        DIRECTORY_LIST="$@"
    fi
else
    COUNTER=0
    if [ -n "$(echo $@ | grep '\-\-type')" ]; then
        TYPE=$(echo $@ | sed 's/^.*--type=//' | awk -F' ' '{print $1}')
        COUNTER=$(( $COUNTER + 1 ))
    fi
    if [ -n "$(echo $@ | grep '\-\-lines')" ]; then
        NO_LINES=$(echo $@ | sed 's/^.*--lines=//' | awk -F' ' '{print $1}')
        COUNTER=$(( $COUNTER + 1 ))
    fi
    for i in $(seq $COUNTER); do
        shift
    done
    if [ "$#" -gt 0 ]; then
        DIRECTORY_LIST="$@"
    fi
fi

for DIR in $DIRECTORY_LIST; do
    if [ -n "$TYPE" ]; then
        LIST=$(find $DIR -type f -name "*.$TYPE" -exec grep "$PATTERN" -l {} \;)
    else
        LIST=$(find $DIR -type f -exec grep "$PATTERN" -l {} \;)
    fi
    for FILE in $LIST; do
        if [ "$NO_LINES" = "0" ]; then
            echo $FILE
        else
            echo -e "----------------------------------------------------\n"
            echo "Ocurrence Found for pattern '$PATTERN'"
            echo "File: $FILE"
            echo -e "----------------------------------------------------\n"
            grep -$NO_LINES --color=auto "$PATTERN" $FILE
            echo -e "\n"
        fi
    done
done
