#!/bin/sh

if [ "x$XDG_SESSION_TYPE" = "xwayland" ] &&
   [ "x$XDG_SESSION_CLASS" != "xgreeter" ] &&
   [  -n "$SHELL" ] &&
   grep -q "$SHELL" /etc/shells &&
   ! (echo "$SHELL" | grep -q "false") &&
   ! (echo "$SHELL" | grep -q "nologin"); then
  if [ "$1" != '-l' ]; then
    exec bash -c "exec -l '$SHELL' -c '$0 -l $*'"
  else
    shift
  fi
fi

exec /usr/bin/sway "$@"
