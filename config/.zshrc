# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source `brew --prefix`/share/antigen/antigen.zsh
source ~/.exportsrc

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

antigen bundle git
# antigen bundle github
antigen bundle npm
antigen bundle sublime
antigen bundle brew
antigen bundle z
# antigen bundle docker-compose
# antigen bundle docker
antigen bundle yarn
antigen bundle cp
antigen bundle httpie
antigen bundle osx
antigen bundle nvm
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle andrewferrier/fzf-z

antigen theme romkatv/powerlevel10k

antigen bundle mafredri/zsh-async
# antigen bundle sindresorhus/pure

antigen apply

export EDITOR='vim'

# shortcut to connect serkan.io
alias serkan.io="ssh -i ~/serkan.io.pem serkanio -t 'tmux attach'"
# Basic shortcuts
alias c="clear; printf '\e[3J'"
alias vi="vim"
alias lst="exa --tree --git-ignore -I node_modules"
alias ls="exa -laFh"
alias reload="exec zsh"
alias edit="$EDITOR ~/.zshrc"
alias dc="docker-compose"
alias cat="bat"
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias gitsub="git submodule update --recursive"
alias code="code-fb"
alias web="cd ~/local/whatsapp/wajs/web"
alias mweb="cd ~/local/whatsapp/mirror/wajs/web"
export BUILD_DIR='~/local/whatsapp/wajs/web/.build'
export WORKING_DIR=$BUILD_DIR'/working'
export OUTPUT_DIR=$BUILD_DIR'/output'
# alias build="web && ./bin/build web --working $WORKING_DIR --output $OUTPUT_DIR"
alias cpu-temp="sudo powermetrics --samplers smc |grep -i \"CPU die temperature\""
alias gpu-temp="sudo powermetrics --samplers smc |grep -i \"GPU die temperature\""

# add support for ctrl+o to open selected file in VS Code
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --git-ignore'
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
function weather() { curl "http://wttr.in/$1?m";}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# eval "$(~/local/whatsapp/wajs/web/scripts/build/bin/build bash-completion)"

export PATH="$PATH:`yarn global bin`:`npm -g bin`"

# added by setup_android_env_var.sh
export ANDROID_SDK=/Users/seko/Library/Android/sdk
export ANDROID_NDK_REPOSITORY=/opt/android_ndk
export ANDROID_HOME=${ANDROID_SDK}
export PATH=${PATH}:${ANDROID_SDK}/tools:${ANDROID_SDK}/tools/bin:${ANDROID_SDK}/platform-tools
alias emulator='/Users/seko/Library/Android/sdk/emulator/emulator'

export PATH="/Users/seko/.deno/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/bitcomplete bit

#compdef build
###-begin-build-completions-###
#
# yargs command completion script
#
# Installation: /Users/seko/local/whatsapp/wajs/web/scripts/build/bin/build bash-completion >> ~/.zshrc
#    or /Users/seko/local/whatsapp/wajs/web/scripts/build/bin/build bash-completion >> ~/.zsh_profile on OSX.
#
_build_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" /Users/seko/local/whatsapp/wajs/web/scripts/build/bin/build --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _build_yargs_completions build
###-end-build-completions-###
export PATH="/usr/local/opt/node@16/bin:$PATH"
