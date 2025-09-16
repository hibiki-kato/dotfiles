#!/bin/zsh

# import .files
$HOME/dotfiles/scripts/dotfile_import.sh

# import nvim config
ln -s ~/dotfiles/nvim ~/.config

source $HOME/.zshrc

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
if [ "$(uname -m)" = "arm64" ] ; then
  (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/${USER}/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install brew packages
brew bundle  --global

# Import cron jobs
crontab $HOME/dotfiles/src/crontab.txt

# Execute defaults.sh
$HOME/dotfiles/scripts/defaults.sh

# Create symlinks
$HOME/dotfiles/scripts/sym_link.sh