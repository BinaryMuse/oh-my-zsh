#function prompt_char {
#    git branch >/dev/null 2>/dev/null && echo '±' && return
#    hg root >/dev/null 2>/dev/null && echo '☿' && return
#    echo '$'
#}

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

local return_status="%{$fg[red]%}%(?..✘)%{$reset_color%}"
# RPROMPT='${return_status}%{$reset_color%}'

# ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="("
# ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX=")"
#
function virtualenv_prompt_info() {
    if [ -n "$VIRTUAL_ENV" ]; then
        if [ -f "$VIRTUAL_ENV/__name__" ]; then
            local name=`cat $VIRTUAL_ENV/__name__`
        elif [ `basename $VIRTUAL_ENV` = "__" ]; then
            local name=$(basename $(dirname $VIRTUAL_ENV))
        else
            local name=$(basename $VIRTUAL_ENV)
        fi
        echo " $ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX$name$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX"
    fi
}

# PROMPT='%{$fg[magenta]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%} %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}$(virtualenv_prompt_info)$(git_prompt_info) '
# PROMPT='%{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}$(virtualenv_prompt_info)$(git_prompt_info) $ '
PROMPT='%{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info) $ '

function iterm2_print_user_vars() {
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
  iterm2_set_user_var pwdShort $(basename $(pwd))
}

export EDITOR=vim
export LESS='-iRX'

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH="/usr/local/bin:$PATH"
export PATH="/Users/mtilley/bin:$PATH"
export PATH="/Users/mtilley/.local/bin:$PATH"
export HOMEBREW_ANALYTICS=1
# export PATH="/Users/mtilley/src/install/go/go/bin:$PATH"
# export PATH="./node_modules/.bin:$PATH"
# export PATH="/Users/mtilley/vert.x/bin:$PATH"
# export GOROOT="/Users/mtilley/src/install/go/go"
# export GOPATH="/Users/mtilley/go"
# export PATH=$PATH:"/Users/mtilley/go/bin"
# export PATH=$PATH:/usr/local/opt/go/libexec/bin
# export PATH=$PATH:/Users/mtilley/src/depot_tools
# export GOARCH=amd64
# export GOOS=darwin

export GOPATH="$HOME/src/go"
export PATH="$PATH:$GOPATH/bin"

eval "$(rbenv init -)"

# [[ -s "/Users/mtilley/.rvm/scripts/rvm" ]] && source "/Users/mtilley/.rvm/scripts/rvm"
# PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "/Users/mtilley/.nvm/nvm.sh" ]] && source "/Users/mtilley/.nvm/nvm.sh"
eval "$(nodenv init -)"
# export PATH="/Users/mtilley/github/github.com/bin:$PATH"
export PATH="/Users/mtilley/.cargo/bin:$PATH"
export PATH="/Users/mtilley/.rbenv/shims:$PATH"

setopt hist_ignore_space
setopt hist_no_store
setopt inc_append_history

setopt autocd
setopt auto_pushd
setopt pushd_ignore_dups

alias ll="ls -lAh"
alias bx="bundle exec"
#alias rake="bundle exec rake"
alias s="git status"
# alias s="echo \"***** Committing as\n***** $(git config user.name)\n\n$(git status)\""
alias d="git diff"
alias ds="git diff --staged"
alias git="hub"

alias ldp="ll ~/.atom/dev/packages"
alias lp="ll ~/.atom/packages"
alias cbranch="git rev-parse --symbolic-full-name --abbrev-ref HEAD"

unsetopt correct_all

export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
# export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT="true"
# export WORKON_HOME=$HOME/.virtualenvs

export GITHUB_API_TOKEN="a1facc9bdeda9964c4927b44f402e6568e6e0c36"

# source /usr/local/bin/virtualenvwrapper.sh
eval $(thefuck --alias)

function auto_virtualenv() {
  if [ -e .venv ]; then
    workon `cat .venv`
  fi
}

function auto_nvmrc() {
  if [ -e .nvmrc ]; then
    nvm use `cat .nvmrc`
  fi
}

function chpwd() {
  auto_virtualenv
  auto_nvmrc
}

# auto_virtualenv
auto_nvmrc

ulimit -n 1024

fortune
