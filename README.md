# .vim dotfiles

My personal vim configuration and bash profile.

## Quick Setup

Run this one-liner to download and execute the setup script:

```bash
wget -O - https://raw.githubusercontent.com/ajcates/.vim/master/setup.sh | bash
```

Or if you prefer to review the script first:

```bash
wget https://raw.githubusercontent.com/ajcates/.vim/master/setup.sh
chmod +x setup.sh
./setup.sh
```

## What does the setup script do?

1. Clones this repository to `~/.vim`
2. Initializes and updates all git submodules
3. Creates symlinks:
   - `~/.vimrc` → `~/.vim/.vimrc`
   - `~/.bash_profile` → `~/.vim/.bash_profile`
4. Backs up any existing files with `.backup` extension

## Manual Setup

If you prefer to set things up manually:

```bash
# Clone the repository
git clone https://github.com/ajcates/.vim.git ~/.vim

# Setup submodules
cd ~/.vim
git submodule update --init --recursive

# Create symlinks
ln -s ~/.vim/.vimrc ~/.vimrc
ln -s ~/.vim/.bash_profile ~/.bash_profile

# Source the bash profile
source ~/.bash_profile
```

## Structure

- `.vimrc` - Vim configuration
- `.bash_profile` - Bash profile configuration
- `bundle/` - Vim plugins as git submodules
- `colors/` - Vim color schemes
- `autoload/` - Vim autoload scripts
- `plugin/` - Vim plugins
- `nerdtree_plugin/` - NERDTree plugins
