#!/usr/bin/bash
source $LOCAL/bin/messages-template.sh

USAGE="toggle-vim-tab [<tab_size>]\ntab_size must be an integer number. Default tab_size is 4."
EXAMPLES=""
INSTRUCTIONS=$(GET_USAGE_INSTRUCTIONS "$USAGE" "$EXAMPLES")

DIRECTORY_LIST=''
PATTERN=''

TAB_SIZE=4
IS_TAB_SPACE=1
VIM_FILE=$CONFIG/nvim/init.vim

if [ "$#" -gt 2 ]; then
    ERROR_MESSAGE 'Too many arguments.' "$INSTRUCTIONS"
fi
if [ "$2" == "no-space" ] || [ "$2" == "ns" ]; then
    IS_TAB_SPACE=0
fi
if [ -n "$1" ]; then
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        TAB_SIZE="$1"
    else
        ERROR_MESSAGE 'Given argument is not a number.'
    fi
else
    echo 'No given argument, then tab_size is set to 4.'
fi

echo 'modifying file '$VIM_FILE' to get tab size equals to '$TAB_SIZE
sed -i 's/^.*set tabstop=.*/set tabstop='$TAB_SIZE'/' $VIM_FILE
sed -i 's/^.*set softtabstop=.*/set softtabstop='$TAB_SIZE'/' $VIM_FILE
sed -i 's/set shiftwidth=.*/set shiftwidth='$TAB_SIZE'/' $VIM_FILE
if [ $IS_TAB_SPACE -eq 0 ]; then
    echo 'avoiding spaces chars on tabulation'
    sed -i 's/set expandtab/"""set expandtab/' $VIM_FILE
    sed -i 's/^.*set softtabstop=.*/set softtabstop=0/' $VIM_FILE
else
    echo 'using spaces chars on tabulation'
    sed -i 's/^.*set expandtab/set expandtab/' $VIM_FILE
fi
