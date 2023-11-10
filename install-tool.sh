#!/usr/bin/bash
TOOLS_HOME="$LOCAL/bin"
source $TOOLS_HOME/messages-template.sh
USAGE="install-tool <CLI TOOL script file | sh | fish>\n\n\tIf sh is given, all '.sh' files will be installed to local user. Analogously for fish and '.fish' files."
EXAMPLES="install-tool my-script.py\nThis will install only my-script command to local user.\n\ninstall-tool sh\nThis will install all commands using '.sh' files."
INSTRUCTIONS=$(GET_USAGE_INSTRUCTIONS "$USAGE" "$EXAMPLES")

INSTALLATION_LOCAL="$LOCAL/bin"

if [ -z "$1" ]; then
    ERROR_MESSAGE 'No argument provided' "$INSTRUCTIONS"
fi

function CLEAR_LINK_IF_EXIST () {
    OCCURRENCE=$(ls $TOOLS_HOME | grep '^'$1'$')
    if [ -n "$OCCURRENCE" ]; then
        echo "Removing already set symlink for $1"
        rm $TOOLS_HOME/$1
    fi
}

function INSTALL_SCRIPT_LOCALLY () {
    FILE="$1.$2"
    cp "$1/$FILE" "$INSTALLATION_LOCAL/$FILE"
    chmod +x $INSTALLATION_LOCAL/$FILE
    ln -s $INSTALLATION_LOCAL/$FILE $INSTALLATION_LOCAL/$1
    echo "Symlink created for $NAME"
}

if [ -n "$(echo $1 | grep -E '^(sh|fish)$')" ]; then
    FORMAT=$1
    for F in $(ls -d */); do
        NAME=$(echo $F | cut -d'/' -f1)
        CLEAR_LINK_IF_EXIST $NAME
        INSTALL_SCRIPT_LOCALLY $NAME $FORMAT
    done
else
    if [ ! -f "$1" ]; then
        ERROR_MESSAGE 'No such file.' "$INSTRUCTIONS"
    fi
    if [ -n "$(echo $1 | grep '/')" ]; then
        NAME=$(echo "$1" | cut -d'/' -f1)
        FILE_NAME=$(echo "$1" | cut -d'/' -f2)
    else
        NAME=$(echo "$1" | cut -d'.' -f1)
        FILE_NAME=$1
    fi
    CLEAR_LINK_IF_EXIST $NAME
    cp $1 $INSTALLATION_LOCAL/$FILE_NAME
    chmod +x $INSTALLATION_LOCAL/$FILE_NAME
    ln -s $INSTALLATION_LOCAL/$FILE_NAME $INSTALLATION_LOCAL/$NAME
    echo "Symlink created for $NAME"
fi
