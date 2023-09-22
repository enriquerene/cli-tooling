#!/usr/bin/env fish
function GET_USAGE_INSTRUCTIONS
    echo 'find-and-replace <regex_find_pattern> <replace_pattern> <file_1>[ <file_2>[ ...]]'
    echo ''
    echo 'default directory for searching is current one.'
end 

if test -z "$argv[1]"
    GET_USAGE_INSTRUCTIONS
    exit
else
    set FIND_PATTERN "$argv[1]"
end
if test -z "$argv[2]"
    GET_USAGE_INSTRUCTIONS
    exit
else
    set REPLACE_PATTERN "$argv[2]"
end
if test -z "$argv[3]"
    GET_USAGE_INSTRUCTIONS
    exit
else
    set FILES_LIST $argv[3..-1]
end

for F in $FILES_LIST
    echo 'for file '$F
    sed -i 's/'$FIND_PATTERN'/'$REPLACE_PATTERN'/g' $F
    grep $REPLACE_PATTERN $F
 end
