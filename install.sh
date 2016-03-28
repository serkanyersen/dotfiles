#!/usr/bin/env bash

set -e
set -u

cd "$(dirname "$0")"
DOTFILES_ROOT=$(pwd)

echo ''

success () {
  sleep 0.1 # Give it a progress feeling
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

info () {
  printf "  [\033[00;34mINFO\033[0m] $1\n"
  sleep 0.2 # Give it a progress feeling
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
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


if [[ -f $DOTFILES_ROOT/.install-done ]]
then
  fail "Dotfiles already installed."
  exit
fi

if [[ -d $HOME/.dotfiles-backup ]]
then
  DATE=$(date +%s)
  info "Old backup folder found. moving to .dotfiles-backup-$DATE"
  mv $HOME/.dotfiles-backup $HOME/.dotfiles-backup-$DATE
  success "Done"
fi

info "Backing up existing files."
mkdir $HOME/.dotfiles-backup

# Find a way to do this expandedn
mv $HOME/.vim* $HOME/.dotfiles-backup
[[ -f $HOME/.zshrc ]] && mv $HOME/.zshrc $HOME/.dotfiles-backup
[[ -f $HOME/.gitconfig ]] && mv $HOME/.gitconfig $HOME/.dotfiles-backup
[[ -f $HOME/.ssh/config ]] && mv $HOME/.ssh/config $HOME/.dotfiles-backup/.ssh-config
[[ -f $HOME/.tmux.conf ]] && mv $HOME/.tmux.conf $HOME/.dotfiles-backup
success "Backup done: $HOME/.dotfiles-backup"

if [[ -d $HOME/.oh-my-zsh ]]
then
  info "oh-my-zsh is already installed."
else
  info "Installing oh-my-zsh."
  curl -L http://install.ohmyz.sh | sh
  # ohmyzsh adds it's own file, remove it
  rm $HOME/.zshrc
  success "Done"
fi

info "Copying new dotfiles"
for file in .vimrc .zshrc .gitconfig .tmux.conf; do
  ln -s $DOTFILES_ROOT/config/$file $HOME
  success "$file linked"
done
# Special path
ln -s $DOTFILES_ROOT/config/.sshconfig $HOME/.ssh/config
success ".ssh/config linked"

success "All dotfiles are linked"

if [[ $SHELL != *"/zsh"* ]]
then
  info "Setting zsh as default for current user."
  sudo chsh -s $(which zsh) $(whoami)
  zsh # switch to zsh
  success "Done"
fi

if [[ ! -d $HOME/bin/ ]]
then
  info "creating local bin folder"
  mkdir $HOME/bin/
  success "$HOME/bin/ Done"
fi

info "Installing 'to' script."
if [[ -f $HOME/bin/to ]]
then
  info "to script was already there. could not install."
else
  ln -s $DOTFILES_ROOT/scripts/to.sh $HOME/bin/to
  chmod +x $HOME/bin/to
  info "to script installed."
fi

info "Installing 'imgcat' script"
if [[ -f $HOME/bin/imgcat ]]
then
  info "imgcat was already there. could not install."
else
  ln -s $DOTFILES_ROOT/scripts/imgcat.sh $HOME/bin/imgcat
  chmod +x $HOME/bin/imgcat
  info "imgcat installed."
fi


info "Files copied, enabling."
set +e
set +u
source $HOME/.zshrc >/dev/null 2>/dev/null
set -e
set -u

# put this file here so we know install was done before
touch $DOTFILES_ROOT/.install-done
success "Enabled"

echo ''
echo '  Install completed.'
