#!/bin/bash

DIR=/tmp/toLwr

if [[ ! -d $DIR ]]; then
    echo $DIR is not a directory
    exit 1
fi

for f in $DIR/*; do
    dir=$(dirname "$f")
    base=$(basename "$f")
    mv $f $dir/${base,,}
done
