#!/bin/bash

function finfo {
    exec > >(column -tl 2)
    while read -r filename; do
        echo -n "file "
        echo $(file $filename)
        echo -n "perms "
        echo $(ls -l $filename | awk '{print $1}')
        echo -n "size "
        echo $(stat -c %s $filename)
        echo -n "User "
        echo $(stat -c %U $filename)
        echo -n "Group "
        echo $(stat -c %G $filename)
        echo -n "LastChange "
        echo $(stat -c %y $filename)
    done
}

find $@ | finfo
