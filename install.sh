#!/bin/bash

if [[ -f $HOME/.install-done ]]
then
  echo "Dotfiles already installed."
  exit 0
fi

echo "Backing up existing files."
mkdir ~/.dotfiles-backup
mv ~/.vim* ~/.dotfiles-backup
mv ~/.zshrc ~/.dotfiles-backup
mv ~/.gitconfig ~/.dotfiles-backup
mv ~/.ssh/config ~/.dotfiles-backup/.ssh-config
mv ~/.tmux.conf ~/.dotfiles-backup
echo "backup done: ~/.dotfiles-backup"

if [[ $SHELL != *"/zsh"* ]]
then
  echo "Setting zsh as default for current user."
  sudo chsh -s $(which zsh) $(whoami)
fi

if [[ -d $HOME/.oh-my-zsh ]]
then
  echo "oh-my-zsh is already installed."
else
  echo "Installing oh-my-zsh."
  curl -L http://install.ohmyz.sh | sh
fi

echo "Copying new dotfiles"
ln -s $HOME/dotfiles/config/.vimrc $HOME
ln -s $HOME/dotfiles/config/.zshrc $HOME
ln -s $HOME/dotfiles/config/.gitconfig $HOME
ln -s $HOME/dotfiles/config/.sshconfig $HOME/.ssh/config
ln -s $HOME/dotfiles/config/.tmux.conf $HOME

echo "Files copied, enabling."
source $HOME/.zshrc

# put this file here so we know install was done before
touch $HOME/.install-done
echo "Install completed."
