#!/bin/bash
PROMPT_COMMAND="echo -ne \"\033]0;${USER}@${HOSTNAME}\007\""

function the_theme {
  local thisdir=$(dirname $BASH_SOURCE)
  . "${thisdir}/liquidprompt"
  . "${thisdir}/pure.theme"
  lp_theme pure
}

the_theme
