#!/bin/bash

if [[ -f $HOME/.install-done ]]
then
  echo "Dotfiles already installed."
  exit 0
fi

if [[ -d $HOME/.dotfiles-backup ]]
then
  $DATE=`date +%s`
  mv $HOME/.dotfiles-backup-$DATE
  echo "- Old backup folder found. moving to .dotfiles-backup-$DATE"
fi

echo "- Backing up existing files."
mkdir $HOME/.dotfiles-backup
mv $HOME/.vim* $HOME/.dotfiles-backup
mv $HOME/.zshrc $HOME/.dotfiles-backup
mv $HOME/.gitconfig $HOME/.dotfiles-backup
mv $HOME/.ssh/config $HOME/.dotfiles-backup/.ssh-config
mv $HOME/.tmux.conf $HOME/.dotfiles-backup
echo "-- backup done: $HOME/.dotfiles-backup"

if [[ $SHELL != *"/zsh"* ]]
then
  echo "- Setting zsh as default for current user."
  sudo chsh -s $(which zsh) $(whoami)
fi

if [[ -d $HOME/.oh-my-zsh ]]
then
  echo "- oh-my-zsh is already installed."
else
  echo "- Installing oh-my-zsh."
  curl -L http://install.ohmyz.sh | sh
fi

echo "- Copying new dotfiles"
ln -s $HOME/dotfiles/config/.vimrc $HOME
ln -s $HOME/dotfiles/config/.zshrc $HOME
ln -s $HOME/dotfiles/config/.gitconfig $HOME
ln -s $HOME/dotfiles/config/.sshconfig $HOME/.ssh/config
ln -s $HOME/dotfiles/config/.tmux.conf $HOME

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
touch $HOME/.install-done

echo "Install completed."
