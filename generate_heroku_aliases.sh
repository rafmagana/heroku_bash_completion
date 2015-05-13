#!/bin/bash

if [ -n "$1" ]; then
  echo "Usage: $0"
  echo
  echo "Outputs the list of all heroku aliases, as a bash associative array"
  exit
fi

echo "declare -A __heroku_aliases=("

source_path=$(locate /lib/heroku/command | head -1)
grep -Rh alias_command ${source_path} | sed -n "s/^ \+alias_command \+[\'\"]\(.*\)[\'\"], *[\'\"]\(.*\)[\'\"]/  [\"\1\"]=\"\2\"/p"

echo ")"
