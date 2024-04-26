export GIT_PS1_SHOWUPSTREAM=verbose
. /opt/homebrew/etc/bash_completion.d/git-prompt.sh

precmd() {
    PS1='%F{red}%1~%f'

    if [ -n "$VIRTUAL_ENV" ]; then
        PS1="$PS1 %F{green}($VIRTUAL_ENV_PROMPT)%f"
    fi

    __git_ps1 "$PS1%F{yellow}" '%f %F{blue}%(!.#.$)%f ' ' : %s'
}
