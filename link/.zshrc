export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="drago"
ZSH_CUSTOM=~/zsh_custom
plugins=()
export PATH=$HOME/bin:/usr/local/bin:$PATH

export EDITOR="vim"
bindkey -v 

bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

setopt AUTO_CD

source $ZSH/oh-my-zsh.sh
