#!/bin/bash

# TODO: detect default shell and check its source files there

FILENAME=~/.bashrc
TARGET_STR="source ~/.cfg/shell/my_configs"

case `grep -Fx "$TARGET_STR" "$FILENAME"  >/dev/null; echo $?` in
  0)
    echo "Config files are already sourced in ${FILENAME}. Skipping..."
    ;;
  1)
    echo "# Import my configurations" >> $FILENAME
    echo "${TARGET_STR}" >> $FILENAME
    ;;
  *)
    echo "ERROR!"
    ;;
esac
