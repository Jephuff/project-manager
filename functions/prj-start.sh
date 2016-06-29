#!/bin/bash
function prj-start {
  . prj-export-variables

  prj-cd "$1"
  if [ $? != 0 ]; then
    exit 1
  fi

  if [ "$EDITOR" == 'sublime' ]; then
    if hash sublime 2>/dev/null; then
      sublime "$SUBLIME_DIR$1.sublime-project" &
    elif hash subl 2>/dev/null; then
      subl "$SUBLIME_DIR$1.sublime-project" &
    else
      echo "could not find sublime command"
    fi
  elif [ "$EDITOR" == 'atom' ]; then
    if hash atom 2>/dev/null; then
      atom .
    else
      echo "no atom command"
    fi
  fi

  if [ "$GIT_CLIENT" == 'source tree' ]; then
    if hash stree 2>/dev/null; then
      while read -r repo; do
        stree "$repo" &
      done < ".config/git-repos"
    else
      echo "stree command not found"
    fi
  else
    echo "no git client set"
  fi

  while read -r script; do
    if hash osascript 2>/dev/null; then
      osascript -e "activate application \"iTerm\""
      osascript -e "tell application \"System Events\" to keystroke \"t\" using command down"
      osascript -e "tell application \"iTerm\" to tell session -1 of current terminal to write text \""$script"\""
    else
      $script
    fi
  done < ".config/new-tab-commands"



  ./start.sh
}
