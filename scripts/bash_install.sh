#!/bin/bash

FILENAME=~/.bashrc
TARGET_STR="source ~/.cfg/shell/my_configs.bash"

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
