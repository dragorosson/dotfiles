export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="drago"
ZSH_CUSTOM=~/zsh_custom
plugins=()
source $ZSH/oh-my-zsh.sh
export PATH=$HOME/bin:/usr/local/bin:$PATH

export HISTFILE=~/.zsh_history
export HISTSIZE=10000000
export SAVEHIST=10000000

export EDITOR="vim"
export KEYTIMEOUT=1
bindkey -v 

bindkey -a u undo

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

function h {
    local cmd_map
    typeset -A cmd_map

    # Column/field 3 because there's an extra space before the command...
    hist=$(history | grep "$@" | grep -v "  h" | grep -v "  hv" | sort -nr | cut -d ' ' -f 3- | uniq)
    local count=0
    local output=$(echo $hist | while read line; do
        if [[ ${+cmd_map[$line]} -eq 0 ]]; then # Associative array contains line
            cmd_map[$line]=1
            echo $line
            ((count++))
        fi

        if [[ count -eq 10 ]]; then
            break
        fi
    done)

    echo $output | nl | sort -nr

    LAST_HGT_OUTPUT=$output
}

function hv {
    history | grep "$@" | vim -
}

function hh {
    history | grep "$@" | tail | awk '{$1 = $1 - '"$HISTCMD"' - 1; print}'
}

function get_hgt_command {
    echo $LAST_HGT_OUTPUT | sed -n ${1}p # Print ${1}th line
}

function f {
    eval $(get_hgt_command $1)
}

function ff {
    eval $(get_hgt_command $1 | perl ~/vipe.pl)
}

function do_gitrefresh {
    if [ $# -ne 2 ]; then
        echo "Use gitrefresh <remote> <branch>"
        return
    fi

    if ! {git diff --exit-code > /dev/null 2>&1 && \
          git diff --cached --exit-code > /dev/null 2>&1}; then
        git status --untracked-files=no
        echo "Uncommitted changes found. Please clean the working directory."
        return
    fi

    git checkout $2 && git pull $1 $2
    git checkout -
}

function git {
    # Custom aliases
    if [[ $1 == "refresh" ]]; then
        do_gitrefresh $2 $3
        return
    fi

    if [[ $1 == "diffc" ]]; then
        git diff --cached
        return
    fi

    if [[ $1 == "addp" ]]; then
        git add --patch
        return
    fi

    # Modifications
    if [[ $1 == "status" ]] && [[ $# -eq 1 ]]; then
        git status -s
        return
    fi

    if [[ $1 == "add" ]] || \
       [[ $1 == "checkout" ]] || \
       [[ $1 == "reset" ]] || \
       [[ $1 == "rm" ]]; then
        command git "$@" && echo "" && git status -s
        return
    fi

    command git "$@"
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

function ssf {
    ssh fedora@$@
}
