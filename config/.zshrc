source /usr/local/share/antigen/antigen.zsh
source ~/.exportsrc

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

antigen bundle git
antigen bundle github
antigen bundle npm
antigen bundle sublime
antigen bundle brew
antigen bundle z
antigen bundle docker-compose
antigen bundle docker
antigen bundle yarn
antigen bundle cp
antigen bundle httpie
antigen bundle osx
antigen bundle nvm
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle andrewferrier/fzf-z

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

antigen theme bhilburn/powerlevel9k powerlevel9k

antigen bundle mafredri/zsh-async
# antigen bundle sindresorhus/pure

antigen apply

export EDITOR='vim'
COMPLETION_WAITING_DOTS="true"
LESSHISTFILE=/dev/null

# shortcut to connect serkan.io
alias serkan.io="ssh -i ~/serkan.io.pem serkanio -t 'tmux attach'"
# Basic shortcuts
alias c="clear"
alias vi="vim"
alias lst="exa --tree --git-ignore"
alias ls="exa -la --git"
alias reload="source ~/.zshrc"
alias edit="$EDITOR ~/.zshrc"
alias dc="docker-compose"
alias cat="bat"
alias preview="fzf --preview 'bat --color \"always\" {}'"
# add support for ctrl+o to open selected file in VS Code
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --git-ignore'
# tools
function weather() { curl "http://wttr.in/$1?m";}
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '~/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source '~/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '~/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then source '~/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ -f '/usr/local/opt/nvm/nvm.sh' ]; then
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh" --no-use
fi

export PATH="$PATH:`yarn global bin`"
