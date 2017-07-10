#
#Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time root_indicator node_version time)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_with_package_name"
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
POWERLEVEL9K_MODE='awesome-patched'
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=$'\uE0B0'
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=$'\ue0b2'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
#POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="$ "

# ZLE_RPROMPT_INDENT=-1

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git github npm sublime brew z docker-compose docker yarn cp httpie osx)

# Activate Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

export EDITOR='vim'

# shortcut to connect serkan.io
alias serkan.io="ssh -i ~/serkan.io.pem serkanio -t 'tmux attach'"
# Basic shortcuts
alias c="clear"
alias vi="vim"
alias xtree="tree -Cat | less"
alias ls="ls -lFaGh"
alias port-forward-enable="echo 'rdr pass inet proto tcp from any to any port 80 -> 127.0.0.1 port 8090' | sudo pfctl -ef -"
alias port-forward-disable="sudo pfctl -F all -f /etc/pf.conf"
alias port-forward-list="sudo pfctl -s nat"
# Connect remote server as a drive
alias mount-serkanio="sshfs -p 22 serkanio:/home/ubuntu ~/serkanio -o auto_cache,reconnect,defer_permissions,negative_vncache,volname=serkanio"
alias reload="source ~/.zshrc"
alias edit="$EDITOR ~/.zshrc"
alias batt="python /Users/serkanyersen/code/scripts/battery.py"
alias sleepsafe='sudo pmset -a destroyfvkeyonstandby 1 hibernatemode 25'
alias sleepfast='sudo pmset -a hibernatemode 0'
alias sleepdefault='sudo pmset -a hibernatemode 3'
alias dc="docker-compose"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias chrome-canary="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary"
alias chromium="/Applications/Chromium.app/Contents/MacOS/Chromium"


function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

# Returns your last pushed commit
function pushed-commit(){
    TAG=`git for-each-ref refs/tags --sort=-authordate --format='%(refname)' --count=1`
    GITHUBUSER=`git config --get github.user`
    AUTHOR=$1
    if test -z "$1"; then
        AUTHOR=$GITHUBUSER
    fi
    echo "execuded: git log $TAG --author=$AUTHOR -1 -U --no-merges"
    git log $TAG --author=$AUTHOR -1 -U --no-merges
}

# don't use less history file
LESSHISTFILE=/dev/null

# Customize to your needs...
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/share/npm/bin

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

source ~/.exportsrc
