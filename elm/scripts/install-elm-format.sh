#!/usr/bin/env bash

# TODO - Make the script more platform and IDE agnostic

ELM_FORMAT_URL="https://github.com/avh4/elm-format/releases/download/0.5.2-alpha/elm-format-0.18-0.5.2-alpha-mac-x64.tgz"

mkdir -p ../resources/bin/
wget -qO- $ELM_FORMAT_URL | tar xvz -C ../resources/bin/
cp -f ../resources/intellij/watcherTasks.xml ../../.idea
