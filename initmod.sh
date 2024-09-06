#! /bin/sh

GITSITE="github.com"
GITUSER="voidwyrm-2"

if [ $# -lt 1 ] || [ "$1" = "-h" ]; then
    printf "expected 'initmod.sh [name]'\n"
    exit 1
fi

if [ "$1" = "example" ] || [ "$1" = "ex" ]; then
    go mod init "example.com/m/v2"
else
    go mod init "$GITSITE/$GITUSER/$1"
fi

go mod tidy