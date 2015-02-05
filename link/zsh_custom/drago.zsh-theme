function TEXT { echo %{$fg[$1]%} }
function BOLD { echo %{$fg_bold[$1]%} }
OFF=%{$reset_color%}

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}

function BOX {
    echo $(TEXT yellow)$(box_name)$OFF
}

function NAME {
    echo $(TEXT magenta)%n$OFF
}

function PATH {
    echo $(TEXT green)%~$OFF
}

function GIT {
    git_prompt_info
}

function VENV {
    echo $(virtualenv_info)
}

function FINAL {
    git branch >/dev/null 2>/dev/null && echo $(TEXT blue)'\xC2\xB1'$OFF && return
    echo $(TEXT red)\$$OFF
}

PROMPT='$(BOX)|$(NAME) $(PATH)$(VENV)$(FINAL) '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_UNTRACKED=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

RPROMPT='$(GIT)'
