#!/bin/bash

echo "executable: $0"
echo 'params using $@'

for i in $@; do
    echo -n $i,
done

echo

echo 'params using $#'

for i in $(seq $#); do
    echo -n $1,
    shift
done

echo
