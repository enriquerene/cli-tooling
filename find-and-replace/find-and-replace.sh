#!/usr/bin/bash
TOOLS_HOME=$LOCAL/bin
source $TOOLS_HOME/messages-template.sh
USAGE="find-and-replace <regex_find_pattern> <replace_value> <file_1>[ <file_2>[ ...]]\n\ndefault directory for searching is current one."
EXAMPLES=""
INSTRUCTIONS=$(GET_USAGE_INSTRUCTIONS "$USAGE" "$EXAMPLES") 

if [ -z "$1" ]; then
    ERROR_MESSAGE 'missing required argument: regex pattern' "$INSTRUCTIONS"
else
    FIND_PATTERN="$1"
fi
if [ -z "$2" ]; then
    ERROR_MESSAGE 'missing required argument: replace value' "$INSTRUCTIONS"
else
    REPLACE_PATTERN="$2"
fi
if [ -z "$3" ]; then
    ERROR_MESSAGE 'You have to include at least one file' "$INSTRUCTIONS"
else
    shift
    shift
    FILES_LIST="$@"
fi

for F in $FILES_LIST; do
    echo "for file $F"
    sed -i "s/$FIND_PATTERN/$REPLACE_PATTERN/g" "$F"
    grep "$REPLACE_PATTERN" $F
 done
