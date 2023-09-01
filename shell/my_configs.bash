
# OS specific configs
OS="`uname`"
case $OS in
  'Linux')
    alias vim='~/Apps/nvim.appimage'
    ;;

  'Darwin') 
    alias awsw='aws2-wrap'
    alias vim='nvim'
    ;;

  *)
esac

eval "$(starship init bash)"

# Use ripgrep when getting files with fzf 
export FZF_DEFAULT_COMMAND='rg --files --ignore-vcs'

# Aliases
alias cn="rg '' $HOME/Sync/Notes/cli/ --no-filename |fzf |grep -o '^[^#]*'"
alias cfg="cd ~/.cfg; vim"
