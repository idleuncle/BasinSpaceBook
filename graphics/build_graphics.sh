#!/bin/bash

for d in `ls *.dot` ; do
    p=$(basename $d .dot).png
    echo "$d -> $p"
    dot -Tpng $d -o $p
done
