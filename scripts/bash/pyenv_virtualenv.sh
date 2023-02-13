#!/bin/bash

VIRTUALENV=$1
CUR_DIR=$(pwd)

if [ -f "$CUR_DIR"/.python-version ]; then
    echo "This directory is already a virtualenv"
    exit 1
elif [ $# -eq 0 ]; then
    echo "$0: Missing argument virtualenv name"
    exit 1
elif [ $# -gt 1 ]; then
    echo "$0: Too many arguments: $*"
    exit 1
else
    echo "creating virtualenv..."
    pyenv virtualenv "$VIRTUALENV" && pyenv local "$VIRTUALENV"
    echo "...virtualenv has been created and activated in this directory"
fi

# move sript to your path to run from anywhere
