#!/bin/bash

if [ -n "$1" ]; then
  echo "Usage: $0"
  echo
  echo "Outputs the list of all heroku commands and subcommands, with their options, as a bash associative array"
  exit
fi

commands=$(heroku help | grep -v '^[A-Z]' | sed -n 's/#.*//p' | tr '\n' ' ')

echo "declare -A __heroku_commands_and_options=("

for cmd in $commands; do
  options="$(heroku help $cmd | grep -o '^ \+--[^ ]\+')"
  echo -n "  [\"$cmd\"]=\""
  for opt in $options; do
    echo -n "$opt "
  done
  echo "\""

  subcommands=$(heroku help $cmd | grep "$cmd:" | awk '{{print $1}}')
  for subcmd in $subcommands; do
    suboptions="$(heroku help $subcmd | grep '^ \+\(-., \)\?--[^ ]\+' | grep -o '\--[^ ]\+')"
    echo -n "  [\"$subcmd\"]=\""
    for subopt in $suboptions; do
      echo -n "$subopt "
    done
    echo "\""
  done
done

echo ")"
