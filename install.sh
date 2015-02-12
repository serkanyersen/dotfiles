#!/bin/bash

if [[ -f $HOME/dotfiles/.install-done ]]
then
  echo "Dotfiles already installed."
  exit 0
fi

if [[ -d $HOME/.dotfiles-backup ]]
then
  DATE=$(date +%s)
  mv $HOME/.dotfiles-backup $HOME/.dotfiles-backup-$DATE
  echo "- Old backup folder found. moving to .dotfiles-backup-$DATE"
fi

echo "- Backing up existing files."
mkdir $HOME/.dotfiles-backup

# Find a way to do this expandedn
mv $HOME/.vim* $HOME/.dotfiles-backup
[[ -f $HOME/.zshrc ]] && mv $HOME/.zshrc $HOME/.dotfiles-backup
[[ -f $HOME/.gitconfig ]] && mv $HOME/.gitconfig $HOME/.dotfiles-backup
[[ -f $HOME/.ssh/config ]] && mv $HOME/.ssh/config $HOME/.dotfiles-backup/.ssh-config
[[ -f $HOME/.tmux.conf ]] && mv $HOME/.tmux.conf $HOME/.dotfiles-backup
echo "-- backup done: $HOME/.dotfiles-backup"

if [[ -d $HOME/.oh-my-zsh ]]
then
  echo "- oh-my-zsh is already installed."
else
  echo "- Installing oh-my-zsh."
  curl -L http://install.ohmyz.sh | sh
  # ohmyzsh adds it's own file, remove it
  rm $HOME/.zshrc
fi

echo "- Copying new dotfiles"
ln -s $HOME/dotfiles/config/.vimrc $HOME
ln -s $HOME/dotfiles/config/.zshrc $HOME
ln -s $HOME/dotfiles/config/.gitconfig $HOME
ln -s $HOME/dotfiles/config/.sshconfig $HOME/.ssh/config
ln -s $HOME/dotfiles/config/.tmux.conf $HOME

if [[ $SHELL != *"/zsh"* ]]
then
  echo "- Setting zsh as default for current user."
  sudo chsh -s $(which zsh) $(whoami)
  zsh # switch to zsh
fi

if [[ ! -d $HOME/bin/ ]]
then
  echo "- creating local bin folder"
  mkdir $HOME/bin/
fi

echo "- Installing 'to' script."
if [[ -f $HOME/bin/to ]]
then
  echo "- to script was already there. could not install."
else
  ln -s $HOME/dotfiles/scripts/to.sh $HOME/bin/to
  chmod +x $HOME/bin/to
fi

echo "- Files copied, enabling."
source $HOME/.zshrc

# put this file here so we know install was done before
touch $HOME/dotfiles/.install-done

echo "Install completed."
