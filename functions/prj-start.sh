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

  while read -r script; do
    echo "$script" >> grep /^\s#/ 2> /dev/null
    if hash prj-new-tab 2>/dev/null; then
      prj-new-tab "$script"
    elif hash osascript 2>/dev/null; then
      osascript -e "activate application \"iTerm\""
      osascript -e "tell application \"System Events\" to keystroke \"t\" using command down"
      osascript -e "tell application \"iTerm\" to tell session -1 of current terminal to write text \""$script"\""
    else
      $script
    fi
  done < $(cat .config/new-tab-commands | grep -v "^\s*\(#\|$\)")

  ./.config/start.sh

  return 0
}
