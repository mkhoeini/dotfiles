#!/usr/bin/env sh

TF=$(mktemp)
fennel --require-as-include -c core.fnl > $TF
mv -f $TF init.lua
