#!/bin/bash

# TODO: detect default shell and check its source files there
FILENAME=~/.bashrc
TARGET_ZSH="source ~/.cfg/shell/my_zsh"
TARGET_STR="source ~/.cfg/shell/my_configs"

# If zsh_version it means zsh is defualt shell
if [ ! -z ${ZSH_VERSION+x} ]; then
    FILENAME=~/.zshrc
fi

case `grep -Fx "$TARGET_STR" "$FILENAME"  >/dev/null; echo $?` in
  0)
    echo "Config files are already sourced in ${FILENAME}. Skipping..."
    ;;
  1)
    echo "# Import my configurations" >> $FILENAME
    echo "${TARGET_STR}" >> $FILENAME

    # Push zsh config if zsh is default
    if [ ! -z ${ZSH_VERSION+x} ]; then
        echo "${TARGET_ZSH}" >> $FILENAME
    fi
    ;;
  *)
    echo "Unexpected response.ERROR!"
    ;;
esac
