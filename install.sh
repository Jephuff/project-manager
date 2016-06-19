#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
COMMAND=". $DIR/.bash_setup $DIR"
grep "$COMMAND" ~/.bash_profile > /dev/null 2> /dev/null
if [ $? != 0 ]; then
  if [ -e ~/.bash_profile ]; then
    echo -e "\n$COMMAND" >> ~/.bash_profile
  else
    echo -e "\n$COMMAND" >> ~/.bashrc
  fi
fi

$COMMAND

mkdir -p $PROJECT_MANAGER_PROJECTS_DIR
