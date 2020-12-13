#!/bin/sh -l

if [ ! -f "$1" ]; then
    echo "File $1 does not exist!" 
    exit 1
fi
mv "$1" /web/game.zip
zip "$1" /web/*