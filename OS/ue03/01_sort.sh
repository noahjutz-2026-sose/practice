#!/bin/bash
exec 1>personal.sort.txt
cat personal.txt | head -n 2
cat personal.txt | tail -n +3 | sort
