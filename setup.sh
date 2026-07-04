#!/usr/bin/env bash

# Setup script for ajcates/.vim dotfiles
# This script installs dependencies, clones the repository, and sets up symlinks.

set -e

echo "=== Setting up .vim dotfiles ==="

# Define colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

REPO_URL="https://github.com/ajcates/.vim.git"
REPO_DIR="$HOME/.vim"
OMZ_DIR="$HOME/.oh-my-zsh"

info() {
    echo -e "${BLUE}$*${NC}"
}

success() {
    echo -e "${GREEN}$*${NC}"
}

warn() {
    echo -e "${YELLOW}$*${NC}"
}

error() {
    echo -e "${RED}$*${NC}" >&2
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

run_with_sudo() {
    if [ "$(id -u)" -eq 0 ]; then
        "$@"
    elif command_exists sudo; then
        sudo "$@"
    else
        error "This step needs root privileges. Install sudo or run as root:"
        error "  $*"
        exit 1
    fi
}

is_termux() {
    [ -n "${TERMUX_VERSION:-}" ] || [[ "${PREFIX:-}" == *com.termux* ]]
}

detect_platform() {
    if is_termux; then
        echo "termux"
        return
    fi

    case "$(uname -s 2>/dev/null || echo unknown)" in
        Linux*)
            if [ -f /etc/debian_version ] || command_exists apt-get; then
                echo "debian"
            else
                echo "linux"
            fi
            ;;
        MINGW*|MSYS*)
            echo "windows-msys"
            ;;
        CYGWIN*)
            echo "windows-cygwin"
            ;;
        *)
            echo "unknown"
            ;;
    esac
}

install_deps_debian() {
    success "Installing dependencies with apt..."
    run_with_sudo apt-get update
    run_with_sudo apt-get install -y git curl zsh
}

install_deps_termux() {
    success "Installing dependencies with pkg..."
    pkg update -y
    pkg install -y git curl zsh
}

install_deps_windows_msys() {
    if command_exists pacman; then
        success "Installing dependencies with pacman..."
        pacman -Sy --needed --noconfirm git curl zsh
    elif command_exists choco; then
        success "Installing available dependencies with Chocolatey..."
        choco install -y git curl || warn "Chocolatey could not install git and curl automatically."
        choco install -y zsh || warn "Chocolatey could not install zsh automatically."
    elif command_exists scoop; then
        success "Installing available dependencies with Scoop..."
        scoop install git curl || warn "Scoop could not install git and curl automatically."
        scoop install zsh || warn "Scoop could not install zsh automatically."
    elif command_exists winget; then
        warn "winget is available, but zsh support depends on your Windows shell distribution."
        winget install --id Git.Git --accept-package-agreements --accept-source-agreements || warn "winget could not install Git automatically."
    else
        warn "No supported Windows package manager found."
        warn "Install git, curl, and zsh manually, then re-run this script."
    fi
}

install_dependencies() {
    platform="$(detect_platform)"

    case "$platform" in
        debian)
            install_deps_debian
            ;;
        termux)
            install_deps_termux
            ;;
        windows-msys)
            install_deps_windows_msys
            ;;
        windows-cygwin)
            warn "Cygwin detected. Please install git, curl, and zsh with the Cygwin installer, then re-run this script."
            ;;
        *)
            warn "Unsupported platform detected. Skipping package installation."
            warn "Make sure git, curl, and zsh are installed before continuing."
            ;;
    esac
}

# Backup existing files if they exist
backup_if_exists() {
    if [ -e "$1" ] && [ ! -L "$1" ]; then
        backup="$1.backup"
        if [ -e "$backup" ]; then
            backup="$1.backup.$(date +%Y%m%d%H%M%S)"
        fi
        info "Backing up existing $1 to $backup"
        mv "$1" "$backup"
    elif [ -L "$1" ]; then
        info "Removing existing symlink $1"
        rm "$1"
    fi
}

link_file() {
    src="$1"
    dest="$2"

    if [ ! -e "$src" ]; then
        warn "Skipping $dest because $src does not exist"
        return
    fi

    backup_if_exists "$dest"

    if ln -s "$src" "$dest" 2>/dev/null; then
        success "Created symlink: $dest -> $src"
    else
        warn "Symlink failed for $dest; copying file instead"
        cp "$src" "$dest"
    fi
}

install_oh_my_zsh() {
    if ! command_exists zsh; then
        warn "zsh is not installed, so Oh My Zsh was not installed."
        warn "Install zsh and re-run this script."
        return
    fi

    if [ -d "$OMZ_DIR" ]; then
        info "Oh My Zsh already exists, skipping install"
        return
    fi

    success "Installing Oh My Zsh..."
    if command_exists curl; then
        RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    elif command_exists wget; then
        RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(wget -O - https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
        warn "curl or wget is required to install Oh My Zsh."
    fi
}

set_default_shell() {
    if ! command_exists zsh; then
        return
    fi

    zsh_path="$(command -v zsh)"
    current_shell="$(basename "${SHELL:-}")"

    if [ "$current_shell" = "zsh" ]; then
        info "zsh is already the default shell"
        return
    fi

    if is_termux; then
        warn "Termux does not use chsh consistently. Start zsh with: zsh"
        return
    fi

    case "$(detect_platform)" in
        windows-*)
            warn "Skipping default shell change on Windows. Start zsh from your terminal profile."
            return
            ;;
    esac

    if command_exists chsh; then
        if [ -w /etc/shells ] && ! grep -qx "$zsh_path" /etc/shells; then
            echo "$zsh_path" >> /etc/shells
        elif [ -f /etc/shells ] && ! grep -qx "$zsh_path" /etc/shells; then
            run_with_sudo sh -c "echo '$zsh_path' >> /etc/shells"
        fi

        if chsh -s "$zsh_path" 2>/dev/null; then
            success "Changed default shell to zsh"
        else
            warn "Could not change default shell automatically. Run: chsh -s $zsh_path"
        fi
    fi
}

install_dependencies

# Clone the repository if it doesn't exist
if [ ! -d "$REPO_DIR" ]; then
    success "Cloning .vim repository..."
    git clone "$REPO_URL" "$REPO_DIR"
else
    info ".vim directory already exists, skipping clone"
fi

# Navigate to the .vim directory
cd "$REPO_DIR"

# Initialize and update submodules
success "Setting up submodules..."
git submodule update --init --recursive

# Create symlinks
success "Creating symlinks..."
link_file "$REPO_DIR/.vimrc" "$HOME/.vimrc"
link_file "$REPO_DIR/.bash_profile" "$HOME/.bash_profile"
link_file "$REPO_DIR/.zshrc" "$HOME/.zshrc"

install_oh_my_zsh
set_default_shell

echo ""
success "=== Setup complete! ==="
info "Your existing files have been backed up with .backup extension if they existed"
info "To apply bash_profile changes, run: source ~/.bash_profile"
if command_exists zsh; then
    info "To start zsh now, run: zsh"
fi
