#!/bin/bash

if [[ $# != 2 ]]; then
    echo "Expected two args, got $#."
    exit 1
fi

if [[ -e $1 ]]; then
    echo "Arg 1 must not exist."
    exit 1
fi

if [[ ! -d $2 ]]; then
    echo "Arg 2 must be a directory."
    exit 1
fi

out=$1
in=$2

tar czf $out $in
