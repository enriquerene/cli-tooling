#!/usr/bin/bash
source ./messages-template.sh
USAGE="install-tool <CLI TOOL script file | sh | fish>\n\n\tIf sh is given, all '.sh' files will be installed to local user. Analogously for fish and '.fish' files."
EXAMPLES="install-tool my-script.py\nThis will install only my-script command to local user.\n\ninstall-tool sh\nThis will install all commands using '.sh' files."
INSTRUCTIONS=$(GET_USAGE_INSTRUCTIONS "$USAGE" "$EXAMPLES")

INSTALLATION_LOCAL="$LOCAL/bin"

if [ -z "$1" ]; then
    ERROR_MESSAGE 'No argument provided' "$INSTRUCTIONS"
fi

case "$1" in
    sh)
        for F in $(ls | grep '\.sh$'); do
            NAME=$(echo $F | cut -d'.' -f1)
            cp $F $INSTALLATION_LOCAL/$F
            chmod +x $INSTALLATION_LOCAL/$F
            ln -s $INSTALLATION_LOCAL/$F $INSTALLATION_LOCAL/$NAME
        done
    ;;
    fish)
        for F in $(ls | grep '\.fish$'); do
            NAME=$(echo $F | cut -d'.' -f1)
            cp $F $INSTALLATION_LOCAL/$F
            chmod +x $INSTALLATION_LOCAL/$F
            ln -s $INSTALLATION_LOCAL/$F $INSTALLATION_LOCAL/$NAME
        done
    ;;
    *)
        if [ ! -f "$1" ]; then
            ERROR_MESSAGE 'No such file.' "$INSTRUCTIONS"
        fi
        NAME=$(echo "$1" | cut -d'.' -f1)
        cp $1 $INSTALLATION_LOCAL/$1
        chmod +x $INSTALLATION_LOCAL/$1
        ln -s $INSTALLATION_LOCAL/$1 $INSTALLATION_LOCAL/$NAME
    ;;
esac
