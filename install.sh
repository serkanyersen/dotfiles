#!/usr/bin/env bash

set -e
set -u

cd "$(dirname "$0")"
DOTFILES_ROOT=$(pwd)

ST=0
FG_BLACK=30
FG_BLUE=34
FG_WHITE=97

BG_BLACK=40
BG_RED=41
BG_GREEN=42
BG_YELLOW=43
BG_BLUE=44
BG_CYAN=46

COLOR_ERR="\\e[$ST;$FG_WHITE;${BG_RED}m"
COLOR_WARN="\\e[$ST;$FG_BLACK;${BG_YELLOW}m"
COLOR_INFO="\\e[$ST;$FG_WHITE;${BG_BLUE}m"
COLOR_OKAY="\\e[$ST;$FG_BLACK;${BG_CYAN}m"
COLOR_DONE="\\e[$ST;$FG_BLACK;${BG_GREEN}m"
COLOR_DEBG="\\e[$ST;$FG_BLUE;${BG_BLACK}m"

RESET="\\e[0m"

echo ''

success () {
  printf "$COLOR_DONE DONE $RESET %s $RESET\\n" "$1"
}

info () {
  printf "$COLOR_INFO INFO $RESET %s$RESET\\n" "$1"
}

okay () {
  printf "$COLOR_OKAY OKAY $RESET %s$RESET\\n" "$1"
}

warn () {
  printf "$COLOR_WARN WARN $RESET %s$RESET\\n" "$1"
}

debg () {
  printf "$COLOR_DEBG DEBG $RESET %s$RESET\\n" "$1"
}

fail () {
  printf "$COLOR_ERR ERR! $RESET %s$RESET\\n" "$1"
  echo ''
  exit
}

error () {
  local parent_lineno="$1"
  local message="$2"
  local code="${3:-1}"

  if [[ -n "$message" ]] ; then
    fail "Error on line ${parent_lineno}: ${message}; exit ${code}"
  else
    fail "Error on line ${parent_lineno}; exit ${code}"
  fi

  exit "${code}"
}
trap 'error ${LINENO}' ERR

# safe_run () {
#     set +e
#     local log="&>$LOGFILE"

#     eval "$1 $log"
#     if [[ $? -ne 0 ]]; then
#         if [[ -n "${2+x}" ]]; then
#             fail "$2"
#         else
#             fail "$1 failed, please check $LOGFILE"
#         fi
#         set -e
#         exit 1
#     fi
# }

# success "nice"
# info "info yea"
# debg "debug"
# okay "this is ok"
# warn "warning!"
# fail "this was fatal"

if [[ -f $DOTFILES_ROOT/.install-done ]]
then
  fail "Dotfiles already installed."
  exit
fi

if [[ -d $HOME/.dotfiles-backup ]]
then
  DATE=$(date +%s)
  info "Old backup folder found. moving to .dotfiles-backup-$DATE"
  mv "$HOME/.dotfiles-backup" "$HOME/.dotfiles-backup-$DATE"
  success "Done"
fi

info "Backing up existing files."
mkdir "$HOME/.dotfiles-backup"

if [[ -d $HOME/.vim ]]
then
    mv "$HOME/.vim*" "$HOME/.dotfiles-backup"
fi

[[ -f $HOME/.zshrc ]] && mv "$HOME/.zshrc" "$HOME/.dotfiles-backup"
[[ -f $HOME/.gitconfig ]] && mv "$HOME/.gitconfig" "$HOME/.dotfiles-backup"
[[ -f $HOME/.ssh/config ]] && mv "$HOME/.ssh/config" "$HOME/.dotfiles-backup/.ssh-config"
[[ -f $HOME/.tmux.conf ]] && mv "$HOME/.tmux.conf" "$HOME/.dotfiles-backup"
success "Backup done: $HOME/.dotfiles-backup"

info "Copying new dotfiles"
for file in .vimrc .zshrc .gitconfig .tmux.conf; do
  ln -s "$DOTFILES_ROOT/config/$file" "$HOME"
  success "$file linked"
done

# Special path
ln -s "$DOTFILES_ROOT/config/.sshconfig" "$HOME/.ssh/config"
success ".ssh/config linked"

touch ~/.exportsrc
success "exports file created"

if [[ "$OSTYPE" == "darwin"* ]]; then
  info "Installing Homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  success "Homebrew installed."
elif [[ "$OSTYPE" == "linux"* ]]; then
  mv ~/.gitconfig ~/.gitconfig.tmp
  info "Installing Linuxbrew"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"


  test -d ~/.linuxbrew && PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"
  test -d /home/linuxbrew/.linuxbrew && PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
  test -r ~/.bash_profile && echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.bash_profile
  echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.profile
  echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >> ~/.exportsrc

  sudo apt-get install build-essential -y
  brew install gcc -y
  # sudo echo "LC_ALL=en_US.UTF-8" >> /etc/environment
  # sudo echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
  # sudo echo "LANG=en_US.UTF-8" > /etc/locale.conf
  # sudo locale-gen en_US.UTF-8
  mv ~/.gitconfig.tmp ~/.gitconfig
fi

info "Install brew packages"
brew install antigen httpie hub vim exa bat fzf nvm yarn fd jq tig tmux
success "Packages are installed"

success "All dotfiles are linked"

touch ~/.exportsrc
success "Exports file created"

if [[ $SHELL != *"/zsh"* ]]
then
  info "Setting zsh as default for current user."
  sudo chsh -s "$(command -v zsh)" "$(whoami)"
  zsh # switch to zsh
  success "Done"
fi

if [[ ! -d $HOME/bin/ ]]
then
  info "creating local bin folder"
  mkdir "$HOME/bin/"
  success "$HOME/bin/ Done"
fi

info "Files copied, enabling."
set +e
set +u
# shellcheck source=/dev/null
. "$HOME/.zshrc" >/dev/null 2>/dev/null
set -e
set -u

# put this file here so we know install was done before
touch "$DOTFILES_ROOT/.install-done"
success "Enabled"

echo ''
echo '  Install completed.'
