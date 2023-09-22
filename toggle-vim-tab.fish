#!/usr/bin/env fish
function GET_USAGE_INSTRUCTIONS
    echo 'toggle-vim-tab [<tab_size>]'
    echo ''
    echo 'tab_size must be an integer number. Default tab_size is 4.'
end 

set TAB_SIZE 4
set VIM_FILE $CONFIG/nvim/init.vim

if test -n "$argv[1]"
    if string match -qr '^[0-9]+$' "$argv[1]"
        set TAB_SIZE "$argv[1]"
    else
        GET_USAGE_INSTRUCTIONS
        exit
    end
else
    echo 'No given argument, tab_size set to 4.'
end

echo 'modifying file '$VIM_FILE' to get tab size equals to '$TAB_SIZE
sed -i 's/^.*set tabstop=.*/set tabstop='$TAB_SIZE'/' $VIM_FILE
sed -i 's/^.*set softtabstop=.*/set softtabstop='$TAB_SIZE'/' $VIM_FILE
sed -i 's/set shiftwidth=.*/set shiftwidth='$TAB_SIZE'/' $VIM_FILE
