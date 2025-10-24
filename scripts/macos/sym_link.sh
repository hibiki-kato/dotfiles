#!/bin/zsh
# Dropbox symlink for $HOME
ln -s ~/Library/CloudStorage/Dropbox ~/Dropbox

# iPhone backup symlink for Dropbox
ln -s  ~/Library/CloudStorage/Dropbox/iPhone_Backup ~/Library/Application\ Support/MobileSync/Backup

# Chezmoi symlink for $HOME
ln -s ~/.local/share/chezmoi ~/chezmoi