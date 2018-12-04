#!/bin/bash
#This is a gnuclient, still under development for use over SSH
#This originally comes from XEmacs beta code.
#Modified by: Chris Green <cmg(at)dok.org>
#GPL License: See file COPYING for details

if gnuclient -batch -eval t >/dev/null 2>&1
then

  if [ "$XAUTHORITY" != "" ]; then
     gnuclient -batch -f "shell-command \"xauth merge $XAUTHORITY\"" \
        >/dev/null 2>&1
  fi
  exec gnuclient -q ${1+"$@"}
else
  xemacs -unmapped -f gnuserv-start &
  until gnuclient -batch -eval t >/dev/null 2>&1
  do
     sleep 1
  done
  exec gnuclient -q ${1+"$@"}
fi
