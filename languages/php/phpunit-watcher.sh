#!/usr/bin/env bash

RUN="clear && bin/phpunit"
[[ -n $@ ]] && ARGS=$@ || ARGS="--colors=always test"

watchman-make \
    -p 'src/**/*.php' 'test/**/*.php' \
    --make="$RUN" \
    -t "$ARGS"