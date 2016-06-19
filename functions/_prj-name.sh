#!/bin/bash
_prj-name (){
  . prj-export-variables
  COMPREPLY=()
  if [ $3 = "prj-start" -o $3 = "prj-cd" -o $3 = "prj-archive" -o $3 = "prj-remove" -o $3 = "prj-restore" ]; then
    COMPREPLY=( $( compgen -W "$({ ls "$WORKING_DIR" ; ls "$ARCHIVE_DIR" ; })" -- ${COMP_WORDS[COMP_CWORD]} ) )
  fi
  return 0
}