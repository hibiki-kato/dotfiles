#!/bin/zsh

# import .files
$HOME/dotfiles/scripts/dotfile_import.sh


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
