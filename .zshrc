bindkey -v

export HISTSIZE=50000
export SAVEHIST=10000

setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
setopt share_history

alias ll='ls -al'
alias ls='ls -G'
alias grep='grep --color=auto'

if [ -x '/opt/homebrew/bin/brew' ]; then
    eval $(/opt/homebrew/bin/brew shellenv)
    fpath+=($(brew --prefix)/share/zsh/site-functions)
fi

if type brew &>/dev/null && [ -d "$(brew --prefix)/share/zsh-completions" ]; then
    fpath+=$(brew --prefix)/share/zsh-completions
fi

if type brew &>/dev/null && [ -d "$(brew --prefix)/share/zsh-syntax-highlighting" ]; then
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if type brew &>/dev/null && [ -d "$(brew --prefix)/share/zsh-autosuggestions" ]; then
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    bindkey '^Y' autosuggest-accept

    export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
fi

if type nvim &>/dev/null; then
    alias vi='nvim'
    alias vimdiff='nvim -d'
fi

if type bat &>/dev/null; then
    alias cat='bat'
fi

if type kubectl &>/dev/null; then
    alias k='kubectl'
fi

if type kubectx &>/dev/null; then
    alias x='kubectx'
    alias n='kubens'
    alias dd='kubectx docker-desktop'
fi

export MANWIDTH=80

. "$HOME/.config/fzf/themes/rose-pine.sh"

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --preview-window right,40%,sharp --cycle --height 50% --border sharp --info inline --color label:bold --tabstop 1 --layout reverse --exit-0 --select-1"
export FZF_CTRL_T_OPTS="--preview '[ -f {} ] && bat -n --color=always {} || tree -C {}' --walker-skip .git,node_modules,target"
export FZF_CTRL_R_OPTS="--preview 'echo {2..}' --preview-window right,40%,sharp,wrap"
export FZF_ALT_C_OPTS="--preview 'tree -C {}' --walker-skip .git,node_modules,target"

if type fzf &>/dev/null; then
    eval "$(fzf --zsh)"
fi

if type zoxide &>/dev/null; then
    export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS --preview 'tree -C {2..}' --exact --no-sort"
    eval "$(zoxide init zsh)"
fi

if type direnv &>/dev/null; then
    eval "$(direnv hook zsh)"
fi

if type go &>/dev/null; then
    GOBIN=$(go env GOBIN)
    [ -z "$GOBIN" ] && GOBIN=$(go env GOPATH)/bin
    path+=($GOBIN)
fi

export GIT_LFS_SKIP_SMUDGE=1
export GIT_PS1_SHOWUPSTREAM=verbose

precmd () {
    PS1='%F{red}%2~%f'
    if [ -n "$VIRTUAL_ENV" ]; then
        PS1="$PS1 %F{green}($VIRTUAL_ENV_PROMPT)%f"
    fi

    if type brew &>/dev/null && [ -f "$(brew --prefix)/etc/bash_completion.d/git-prompt.sh" ]; then
        . $(brew --prefix)/etc/bash_completion.d/git-prompt.sh
        __git_ps1 "$PS1%F{yellow}" '%f %F{blue}%(!.#.$)%f ' ' : %s'
    fi
}

autoload -Uz compinit
compinit -u
