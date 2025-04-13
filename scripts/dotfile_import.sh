#!/bin/zsh

# Directory containing the dotfiles
DOTFILES_DIR="$HOME/dotfiles/.files"

# Move each file from the dotfiles directory to the home directory
for file in "$DOTFILES_DIR"/.*; do
    # Get the base name of the file
    filename=$(basename "$file")
    
    # Move the file to the home directory
    mv "$file" "$HOME/$filename"
done

echo "Dotfiles have been moved to $HOME. Setting up symlinks..."

zsh $HOME/dotfiles/scripts/dotfile_update.sh

echo "Symlinks have been created."
echo "Please restart your terminal or run 'source ~/.zshrc' to apply the changes."