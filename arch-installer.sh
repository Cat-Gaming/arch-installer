#!/bin/bash

if [[ $(ls -A) ]]; then
    echo "there are files"
else
    echo "no files found"
fi
