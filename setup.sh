#!/bin/sh -e

rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

command_exists() {
  for cmd in "$@"; do
    command -v "$cmd" >/dev/null 2>&1 || return 1
  done
  return 0
}

installNeovim() {
    if ! command_exists nvim ripgrep git fzf lua; then
        printf "%b\n" "Installing Neovim..."
        sudo pacman -S --needed --noconfirm neovim ripgrep fzf luarocks shellcheck git lua
    else
        printf "%b\n" "Neovim is already installed."
    fi
}

linkNeovimConfig() {
    printf "Linking Neovim Configuration Files..."
    TEMP_DIR=$(mktemp -d -t neovim-XXXXXX)
    git clone https://github.com/gameshler/neovim.git "$TEMP_DIR/neovim"
    mkdir -p "$HOME/.config/nvim"
    cp -r "$TEMP_DIR/neovim/lua" "$HOME/.config/nvim/"
    cp -r "$TEMP_DIR/neovim/init.lua" "$HOME/.config/nvim/"
    cp -r "$TEMP_DIR/neovim/lazy-lock.json" "$HOME/.config/nvim/"

    rm -rf "$TEMP_DIR"
    printf "Setup Complete! You may run nvim."
}

installNeovim
linkNeovimConfig
