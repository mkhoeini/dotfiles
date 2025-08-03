#!/usr/bin/env sh

TF=$(mktemp)
fennel --require-as-include -c src/core.fnl > $TF
mv -f $TF init.lua
