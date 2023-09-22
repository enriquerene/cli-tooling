#!/usr/bin/bash
function GET_CURRENT_BRANCH () {
    git branch | grep '*' | cut -d' ' -f2
}
function GET_USAGE_INSTRUCTIONS () {
    PROGRAM_NAME=$(echo $0 | rev | cut -d'/' -f1 | rev)
    echo $PROGRAM_NAME': This is a shortcut for git add and git commit commands.'
    echo ''
    echo 'Usage: '$PROGRAM_NAME' <MESSAGE> [<FILE1>[ <FILE2>[ ...]]]'
    echo 'What will work exactly as `git add <FILE1>[ <FILE2>[ ...]] && git commit -m <MESSAGE>`'
    echo ''
    echo 'If only <MESSAGE> is given '$PROGRAM_NAME' will run `git add . && git commit -m <MESSAGE>`'
}

if [ -z "$1" ]; then
    GET_USAGE_INSTRUCTIONS
    exit
else
    MESSAGE="$1"
fi
if [ "$#" -gt 1 ]; then
    FILES='.'
else
    shift
    FILES="$@"
fi

git add "$FILES"
git commit -m "$MESSAGE"

echo "Would you like to push this commit? [yes]"
read DO_PUSH
if [ "$DO_PUSH" == 'yes' ] || [ -z "$DO_PUSH" ]; then
    CURRENT_BRANCH=$(GET_CURRENT_BRANCH)
    echo "What branch would you push into? [$CURRENT_BRANCH]"
    read BRANCH
    if [ -z "$BRANCH" ]; then
        BRANCH="$CURRENT_BRANCH"
    fi
    echo "It's going to push commits from current branch into remote branch $BRANCH. Are you sure this is what you want to run? [yes]"
    read SURE
    if [ "$SURE" == 'yes' ] || [ -z "$SURE" ]; then
        git push origin $BRANCH
    fi
fi
