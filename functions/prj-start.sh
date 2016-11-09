#!/bin/bash
function prj-start {
  . prj-export-variables

  prj-cd "$1"

  if [ $? != 0 ]; then
    return 1
  fi

  if [ "$EDITOR" != "" ]; then
    $EDITOR . &
  fi

  if [ "$GIT_CLIENT" != "" ]; then
    while read -r repo; do
      $GIT_CLIENT "$repo" &
    done < ".config/git-repos"
  fi

  cat .config/new-tab-commands | grep -v "^\s*\(#\|$\)" | while read -r script; do
    if [ $? == 0 ]; then
      if hash prj-new-tab 2>/dev/null; then
        prj-new-tab "${script//\"/\\\"}"
      else
        echo run: $script
      fi
    fi
  done

  ./.config/start.sh

  return 0
}
