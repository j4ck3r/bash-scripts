#!/bin/bash
# Script to select a file in fzf and open it in ranger

f=$(fzf)
if [[ -z $f ]]
then
    exit 0
fi

ranger --selectfile=$f
