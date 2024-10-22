#! /bin/sh

u=1
ui=0
uv=""
i=0
for a in "$@"
do
    if [ "$a" = "-u" ]; then
        # shellcheck disable=SC2034
        u=0
        ui=$i
    elif [ "$i" = "$((ui+1))" ]; then
        uv="$a"
    fi
    i=$((i+1))
done

git add .
if [ $# -ge 1 ]; then
    git commit . -m "$1"
else
    git commit .
fi

# shellcheck disable=SC2078
if [ "$uv" != "" ] && [ u ]; then
    git remote add origin "$uv"
    git push -u origin main
else
    git push
fi
