export GIT_PS1_SHOWUPSTREAM=verbose
. /opt/homebrew/etc/bash_completion.d/git-prompt.sh

precmd() {
    __git_ps1 '%B%F{blue}[%m]%b %F{red}%1~%F{yellow}' ' %F{blue}%(!.#.$)%f ' ' : %s'
}
