export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="drago"
ZSH_CUSTOM=~/zsh_custom
plugins=()
source $ZSH/oh-my-zsh.sh
export PATH=$HOME/bin:/usr/local/bin:$PATH

export EDITOR="vim"
export KEYTIMEOUT=1
bindkey -v 

bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward
bindkey "^?" backward-delete-char

setopt AUTO_CD

# changes command-line cursor shape based on mode
function zle-keymap-select zle-line-init {
  case $KEYMAP in
    vicmd)      print -n -- "\E]50;CursorShape=0\C-G";; # block cursor
    viins|main) print -n -- "\E]50;CursorShape=1\C-G";; # line cursor
  esac

  zle reset-prompt
  zle -R
}

function zle-line-finish
{
    print -n -- "\E]50;CursorShape=0\C-G"  # block cursor
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

