#!/bin/bash
function prj-cd {
  . prj-export-variables

  if [ ! -d "$WORKING_DIR" ]; then
    echo "working directory not set"
    exit 1
  fi

  if [ ! -d "$ARCHIVE_DIR" ]; then
    echo "archive directory not set"
    exit 1
  fi

  if [ -d "$WORKING_DIR$1" ]; then
    cd "$WORKING_DIR$1"
  elif [ -d "$ARCHIVE_DIR$1" ]; then
    cd "$ARCHIVE_DIR$1"
  else
    echo "project doesn't exists"
    exit 1
  fi
}