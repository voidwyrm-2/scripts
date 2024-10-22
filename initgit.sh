#! /bin/sh

LICENSEPATH="$HOME/Repos/LICENSES"
SCRIPTPATH="$HOME/scripts"

initGitRepo() {
    if ! [ -f "./.git" ]; then
        git init
    fi

    if ! [ -f "./commit.sh" ]; then
        cat "$SCRIPTPATH/commit.sh" > "./commit.sh"
        chmod "744" "./commit.sh"
    fi

    if ! [ -f "./readme.md" ]; then
        echo "# " > "./readme.md"
    fi

    if ! [ -f "./.gitignore" ]; then
        echo "commit.sh" > "./.gitignore"
        { echo "build/"; echo "test/build/"; echo "compile/"; echo "dist/"; echo ".DS_Store"; echo ".vscode"; echo "__pycache__"; } >> "./.gitignore"
    fi
}



showHelp() {
    echo "initgit.sh [-h | --help] [mit | gpl | apache]" #"initgit.sh [ -l [mit | gpl | apache] | [-h | --help] ] [gitignore languages/APIs/OS's/etc, e.g. 'macos,python,go']"
    exit
}


copyLicense() {
    if ! [ -f "./LICENSE" ]; then
        cat "$LICENSEPATH/$1.txt" > "./LICENSE"
    fi
}


getLicense() {
    if [ "$1" = "mit" ]; then
        copyLicense "MIT"
    elif [ "$1" = "gpl" ]; then
        copyLicense "GNU-GPL"
    elif [ "$1" = "apache" ]; then
        copyLicense "Apache"
    else
        echo "expected 'mit', 'gpl', or 'apache', not '$1'"
        exit
    fi
}


# program


if [ $# -gt 0 ]; then
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        showHelp
    else
       getLicense "$1"
       #if ! [ -f "./.gitignore" ] && [ $# -gt 1 ]; then
       #    ~/scripts/initgitignore.sh "$2"
       #fi
    fi
    initGitRepo
else
    showHelp
fi