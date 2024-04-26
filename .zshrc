# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/opt/homebrew/bin:$HOME/go/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@15/libexec/bin:$PATH"

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
plugins=(fzf macos zoxide direnv zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# use vim key bindings
bindkey -v

alias ll='ls -al'
alias ls='ls -G'
alias grep='grep --color=auto'
alias cat='bat'
alias ekam='make -f Makefile.local'

alias k='kubectl' x='kubectx' n='kubens'
alias dd='kubectx docker-desktop'
alias anchor='docker run --rm -it -v $PWD:/mnt/$(basename $PWD) --workdir /mnt/$(basename $PWD)'

alias tf='terraform'

alias vi='nvim'
alias vimdiff='nvim -d'

alias pip='pip3 --require-virtualenv'

touch() { mkdir -p $(dirname $*); /usr/bin/touch $*; }

status() { echo >&2 ">>> $*"; }

clone() {
  local GROUP=$(basename $(dirname $1))
  local NAME=$(basename $1)

  case $1 in
    git@*) GROUP=${GROUP##*:} ;;
  esac

  REPO_PATH="$HOME/git/$GROUP/${NAME%.git}"

  if [ -d "$REPO_PATH" ]; then
    status "$GROUP/$NAME already exists"
    cd $REPO_PATH
    return
  fi

  mkdir -p $(dirname $REPO_PATH)
  git clone $1 $REPO_PATH
  cd $REPO_PATH
}

export MANWIDTH=80

export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!**/.git/*" --glob "!**/node_modules/*" --no-ignore --smart-case'
export FZF_DEFAULT_OPTS="
  --preview-window right,40%,sharp
  --cycle
  --height 50%
  --border sharp
  --info inline
  --color label:bold
  --tabstop 1
  --layout reverse
  --exit-0
  --select-1
"

export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS --preview 'bat -n --color=always {}'"

export FZF_CTRL_R_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_R_OPTS="$FZF_DEFAULT_OPTS --preview 'echo {2..}' --preview-window right,40%,sharp,wrap"

export FZF_ALT_C_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_ALT_C_OPTS="$FZF_DEFAULT_OPTS --preview 'tree -C {2..}'"

export GIT_LFS_SKIP_SMUDGE=1

export no_proxy='*'

if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:$FPATH"
  autoload -Uz compinit
  compinit
fi

if type zoxide &>/dev/null; then
  export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS --preview 'tree -C {2..}' --exact --no-sort"
  eval $(zoxide init zsh)
fi

if [ "$(id -u)" -eq 0 ]; then
  return
fi
