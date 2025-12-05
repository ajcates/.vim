#!/bin/bash

# Setup script for ajcates/.vim dotfiles
# This script clones the repository and sets up symlinks

set -e

echo "=== Setting up .vim dotfiles ==="

# Define colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Backup existing files if they exist
backup_if_exists() {
    if [ -e "$1" ] && [ ! -L "$1" ]; then
        echo -e "${BLUE}Backing up existing $1 to $1.backup${NC}"
        mv "$1" "$1.backup"
    elif [ -L "$1" ]; then
        echo -e "${BLUE}Removing existing symlink $1${NC}"
        rm "$1"
    fi
}

# Clone the repository if it doesn't exist
if [ ! -d "$HOME/.vim" ]; then
    echo -e "${GREEN}Cloning .vim repository...${NC}"
    git clone https://github.com/ajcates/.vim.git "$HOME/.vim"
else
    echo -e "${BLUE}.vim directory already exists, skipping clone${NC}"
fi

# Navigate to the .vim directory
cd "$HOME/.vim"

# Initialize and update submodules
echo -e "${GREEN}Setting up submodules...${NC}"
git submodule update --init --recursive

# Create symlinks
echo -e "${GREEN}Creating symlinks...${NC}"

backup_if_exists "$HOME/.vimrc"
ln -s "$HOME/.vim/.vimrc" "$HOME/.vimrc"
echo -e "${GREEN}Created symlink: ~/.vimrc -> ~/.vim/.vimrc${NC}"

backup_if_exists "$HOME/.bash_profile"
ln -s "$HOME/.vim/.bash_profile" "$HOME/.bash_profile"
echo -e "${GREEN}Created symlink: ~/.bash_profile -> ~/.vim/.bash_profile${NC}"

echo ""
echo -e "${GREEN}=== Setup complete! ===${NC}"
echo -e "${BLUE}Your existing files have been backed up with .backup extension if they existed${NC}"
echo -e "${BLUE}To apply bash_profile changes, run: source ~/.bash_profile${NC}"
