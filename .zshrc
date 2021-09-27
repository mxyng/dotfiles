# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/bin:/opt/homebrew/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME=myang

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(docker fzf kubectl z)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

unsetopt share_history

alias ll='ls -al'
alias ls='ls -G'
alias grep='grep --color=auto'
alias goto='z git'

alias k='kubectl'
alias anchor='docker run --rm -it -v $PWD:/mnt --workdir /mnt'

:<<EOF
helm() {
    local OPTIND
    local HELM_RUN='docker run'
    local HELM_ARGS="--rm -v $HOME/.kube:/root/.kube -v $HOME/.helm:/root/.helm -v $PWD:/mnt --workdir /mnt"
    local HELM_DEBUG=0
    local HELM_VERSION='3.6.3'
    while getopts "di" OPTION; do
        case $OPTION in
            d) HELM_DEBUG=1 ;;
            i) HELM_ARGS="$HELM_ARGS -it --entrypoint sh" ;;
        esac
    done

    shift $(( $OPTIND - 1 ))
    [ "$HELM_DEBUG" -eq 1 ] && echo $HELM_RUN $HELM_ARGS alpine/helm:$HELM_VERSION $@
    eval $HELM_RUN $HELM_ARGS alpine/helm:$HELM_VERSION $@
}
EOF

status() { echo >&2 ">>> $*"; }
error() { status "ERROR: $*"; }

chk8s() {
     usage() { echo 'usage: chk8s KUBECONFIG [-c CONTEXT] [-n NAMESPACE]'; }

    [ -z "$1" ] && usage && return

    local OPTIND=2 OPTION OPTARG
    local CONTEXT NAMESPACE
    local KUBEDIR="$HOME/.kube"
    while getopts "c:n:" OPTION; do
        case $OPTION in
            c) CONTEXT=$OPTARG ;;
            n) NAMESPACE=$OPTARG ;;
            *) usage; return ;;
        esac
    done

    local KUBECONFIG="$KUBEDIR/$1.yaml"
    [ ! -f "$KUBECONFIG" ] && error "$1.yaml not found in $KUBEDIR" && return
    ln -sf $HOME/.kube/$1.yaml $HOME/.kube/config

    MSG="Switched to configuration \"$1\""
    if [ -n "$CONTEXT" ]; then
        kubectl config use-context $CONTEXT >/dev/null
        MSG="$MSG : context \"$CONTEXT\""
    fi

    if [ -n "$NAMESPACE" ]; then
        kubectl config set-context --current --namespace=$NAMESPACE >/dev/null
        MSG="$MSG (namespace \"$NAMESPACE\")"
    fi

    echo "$MSG."
}

dd() {
    if [ $# -eq 0 ]; then
        chk8s dd -c docker-desktop
    else
        kubectl --kubeconfig ~/.kube/dd.yaml --context docker-desktop $*
    fi
}

export LESS_TERMCAP_mb=$'\033[01;31m'
export LESS_TERMCAP_md=$'\033[01;36m'
export LESS_TERMCAP_me=$'\033[00m'
export LESS_TERMCAP_so=$'\033[01;44;33m'
export LESS_TERMCAP_se=$'\033[00m'
export LESS_TERMCAP_us=$'\033[04;31m'
export LESS_TERMCAP_ue=$'\033[00m'

export MANWIDTH=80

# export FZF_DEFAULT_COMMAND='ag --hidden --ignore-dir=".git" -p ".gitignore" -p "~/.gitignore" -g ""'
export FZF_DEFAULT_COMMAND="rg --files --hidden --no-ignore --smart-case"

[ -z "$TMUX" ] && [ "$(id -u)" -ne 0 ] && { tmux attach || exec tmux && exit; }
