# .vim dotfiles

My personal vim configuration and shell profile.

## Quick Setup

Run the setup script directly from GitHub with this one-line command:

```bash
curl -fsSL https://raw.githubusercontent.com/ajcates/.vim/master/setup.sh | bash
```

If `curl` is not available, use `wget`:

```bash
wget -O - https://raw.githubusercontent.com/ajcates/.vim/master/setup.sh | bash
```

To run the script after cloning the repository:

```bash
git clone https://github.com/ajcates/.vim.git ~/.vim
cd ~/.vim
./setup.sh
```

## What does the setup script do?

1. Installs `git`, `curl`, and `zsh` where supported
2. Clones this repository to `~/.vim` if it is not already there
3. Initializes and updates all git submodules
4. Installs Oh My Zsh non-interactively
5. Creates symlinks:
   - `~/.vimrc` → `~/.vim/.vimrc`
   - `~/.bash_profile` → `~/.vim/.bash_profile`
   - `~/.zshrc` → `~/.vim/.zshrc`
6. Backs up any existing files with `.backup` extension

Supported package environments:

- Debian-based Linux distributions, including Ubuntu and WSL Debian/Ubuntu
- Termux
- Windows shells with MSYS2 `pacman`, Chocolatey, Scoop, or winget available

On Windows, native `zsh` availability depends on the shell distribution. If the script cannot install it automatically, install `git`, `curl`, and `zsh`, then run the script again.

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
ln -s ~/.vim/.zshrc ~/.zshrc

# Install zsh and Oh My Zsh
# Debian/Ubuntu:
sudo apt-get install -y zsh curl git
RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Source the bash profile or start zsh
source ~/.bash_profile
zsh
```

## Structure

- `.vimrc` - Vim configuration
- `.bash_profile` - Bash profile configuration
- `.zshrc` - Zsh and Oh My Zsh configuration
- `bundle/` - Vim plugins as git submodules
- `colors/` - Vim color schemes
- `autoload/` - Vim autoload scripts
- `plugin/` - Vim plugins
- `nerdtree_plugin/` - NERDTree plugins
