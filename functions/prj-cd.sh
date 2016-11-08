#!/bin/bash
function prj-cd {
  if [ "$1" == "" ]; then
    return 1
  fi

  . prj-export-variables

  if [ ! -d "$WORKING_DIR" ]; then
    echo "working directory not set"
    return 1
  fi

  if [ -d "$WORKING_DIR$1" ]; then
    cd "$WORKING_DIR$1"
  else
    echo "project doesn't exists"
    return 1
  fi

  return 0
}
