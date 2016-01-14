export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="drago"
ZSH_CUSTOM=~/zsh_custom
plugins=()
source $ZSH/oh-my-zsh.sh
export PATH=$HOME/bin:/usr/local/bin:$PATH

export EDITOR="vim"
export KEYTIMEOUT=1
bindkey -v 

# Causes tmux to autodetect UTF-8 support
export LC_ALL=en_US.UTF-8

bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward
bindkey "^?" backward-delete-char

setopt AUTO_CD

# Changes command-line cursor shape based on mode
function tmux_block_cursor { printf '\033[0 q' }
function tmux_line_cursor { printf '\033[6 q' }
function zsh_block_cursor { print -n -- "\E]50;CursorShape=0\C-G" }
function zsh_line_cursor { print -n -- "\E]50;CursorShape=1\C-G" }

function zle-keymap-select zle-line-init {
  if [[ $TMUX = '' ]]; then
    case $KEYMAP in
      vicmd)      zsh_block_cursor;;
      viins|main) zsh_line_cursor;;
    esac
  else
    case $KEYMAP in
      vicmd)      tmux_block_cursor;;
      viins|main) tmux_line_cursor;;
    esac
  fi

  zle reset-prompt
  zle -R
}

function zle-line-finish {
  if [[ $TMUX = '' ]]; then
    zsh_block_cursor
  else
    tmux_block_cursor
  fi
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

# Aliases
function hgt {
    history | grep "$@" | tail
}

function p {
    if [ "$#" -eq 0 ];
        then tmux display-panes
        return
    fi

    tmux select-pane -t $1
}

function z {
    tmux resize-pane -Z -t $1
}
