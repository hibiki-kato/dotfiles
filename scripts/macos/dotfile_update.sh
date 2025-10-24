#!/bin/zsh

# Move dotfiles to a centralized directory and symlink them from ~
DOTFILES_DIR="$HOME/dotfiles/.files"

# Ensure the dotfiles directory exists
mkdir -p "$DOTFILES_DIR"

# List of top-level dotfiles in ~ (not directories like .config, not . or ..)
EXCLUDE_FILES=(.DS_Store .Trash) # Add any other files you want to exclude
DOTFILES=($(find "$HOME" -maxdepth 1 -type f -name ".*" -exec basename {} \; | grep -vE "$(IFS=\|; echo "${EXCLUDE_FILES[*]}")"))

# 適宜 echo "${DOTFILES[@]}" で中身チェックしてもよい

for file in "${DOTFILES[@]}"; do
    src="$HOME/$file"
    dst="$DOTFILES_DIR/$file"

    # Move the file if it exists and not already moved
    if [ -e "$src" ] && [ ! -L "$src" ]; then
        mv "$src" "$dst"
        echo "📦 Moved $file to $DOTFILES_DIR"
    fi

    # Symlink only if it doesn't already exist
    if [ ! -L "$src" ]; then
        ln -s "$dst" "$src"
        echo "🔗 Created symlink: ~/$file → $dst"
    else
        echo "⏩ Skipped (already symlink): $file"
    fi
done
