#!/usr/bin/env fish
function GET_USAGE_INSTRUCTIONS
    echo 'files-with <regex_pattern> [<directory>[ <grep_around_lines>[ ...]]]'
    echo ''
    echo 'default directory for searching is current one.'
end 

set DIRECTORY_LIST ''
set PATTERN ''

if test -z "$argv[1]"
    GET_USAGE_INSTRUCTIONS
    exit
else
    set PATTERN "$argv[1]"
end
if test -z "$argv[2]"
    set DIRECTORY_LIST '.'
else
    set DIRECTORY_LIST $argv[2]
end
if test -z "$argv[3]"
    set NO_LINES 0
else
    set NO_LINES $argv[3]
end

for DIR in $DIRECTORY_LIST
    for FILE in (find $DIR -type f -exec grep $PATTERN -l {} \;)
        if test "$NO_LINES" = "0"
            echo $FILE
        else
            echo Ocurrence of $PATTERN in $FILE
            echo '---'
            grep -$NO_LINES $PATTERN $FILE
        end
    end
end
