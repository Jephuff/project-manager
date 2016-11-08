#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
COMMAND=". $DIR/.bash_setup $DIR"

if [ -e ~/.bash_profile ]; then
  SOURCE_FILE=~/.bash_profile
else
  SOURCE_FILE=~/.bashrc
fi


grep "$COMMAND" "$SOURCE_FILE" > /dev/null 2> /dev/null

if [ $? != 0 ]; then
  echo -e "\n$COMMAND" >> "$SOURCE_FILE"
fi

$COMMAND
