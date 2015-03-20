#!/bin/bash

if [ $# -ne 2 ]; then
    echo 'usage: make-preference.sh PROFILE RESULT-ID'
    exit 1
fi

awk -F@ -v RES="$2" \
    '{ if($2 == RES) { printf("%d@@%d\n", $1, $2) } }' \
    < "$1"/result
