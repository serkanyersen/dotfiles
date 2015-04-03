#
#Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bira"

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
plugins=(git grunt osx python github brew node npm sublime terminalapp z)

# Activate Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# shortcut to connect serkan.io
alias serkan.io="ssh -i ~/serkan.io.pem serkanio -t 'tmux attach'"
# Basic shortcuts
alias c="clear"
alias vi="vim"
alias tree="tree -Cat | less"
alias ls="ls -laG"
alias port-forward-enable="echo 'rdr pass inet proto tcp from any to any port 80 -> 127.0.0.1 port 8080' | sudo pfctl -ef -"
alias port-forward-disable="sudo pfctl -F all -f /etc/pf.conf"
alias port-forward-list="sudo pfctl -s nat"
# Connect remote server as a drive
alias mount-kodi="sshfs -p 22 osmc@10.0.0.12:/home/osmc/.kodi ~/kodi -o auto_cache,reconnect,defer_permissions,negative_vncache,volname=kodi"

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

# Where I keep python projects
export PYTHONPATH=/Users/serkanyersen/src/

# brew installed android sdk
export ANDROID_HOME=/usr/local/opt/android-sdk
