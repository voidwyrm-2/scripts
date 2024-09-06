#! /bin/sh

if [ $# -lt 1 ] || [ "$1" = "-h" ]; then
    printf "expected 'newgo [new Go project name] [package name]'\n"
    exit 1
fi

mkdir "$1"
# shellcheck disable=SC2164
cd "$1"

if [ $# -gt 1 ] && [ "$2" != "" ]; then #&& [ "$2" != "-g" ] && [ "$2" != "-gm" ] && [ "$2" != "-ga" ] && [ "$2" != "-gp" ] && [ "$2" != "-gg" ]; then
    printf "package %s\n\nfunc main() {\n}" "$2" > main.go
else
    printf "package main\n\nfunc main() {\n}" > main.go
fi

if [ -f "$HOME/scripts/initmod.sh" ]; then
    ~/scripts/initmod.sh "$1"
fi

# if [ "$2" = "-g" ] || [ "$3" = "-g" ] || [ "$2" = "-gm" ] || [ "$3" = "-gm" ]; then
#     ~/scripts/initgit.sh "mit"
# elif [ "$2" = "-ga" ] || [ "$3" = "-ga" ]; then
#     ~/scripts/initgit.sh "apache"
# elif [ "$2" = "-gp" ] || [ "$3" = "-gp" ] || [ "$2" = "-gg" ] || [ "$3" = "-gg" ]; then
#     ~/scripts/initgit.sh "gpl"
# fi

printf "successfully created Go project '%s'\n" "$1"