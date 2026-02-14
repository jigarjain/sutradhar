#!/usr/bin/env bash
#
# This script installs Oh-My-Zsh, plugins & a theme (Powerlevel10K).
# It will NOT over-write the existing .zshrc. .zshrc is overwritten by chezmoi
# in 03_configure.sh
#
set -euo pipefail

main() {
  local omz_dir="$HOME/.oh-my-zsh"
  local themes_dir="$omz_dir/custom/themes"
  local plugins_dir="$omz_dir/custom/plugins"

  if [ ! -d "$omz_dir" ]; then
    echo "⏳ Installing Oh-My-Zsh."
    echo ""
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://install.ohmyz.sh/)" "" --keep-zshrc --unattended
  else
    echo "✔️ Oh-My-Zsh is already installed."
  fi

  mkdir -p "$themes_dir" "$plugins_dir"

  if [ ! -d "$themes_dir/powerlevel10k" ]; then
    echo "⏳ Installing theme: Powerlevel10k."
    echo ""
    git clone -q --depth=1 https://github.com/romkatv/powerlevel10k.git "$themes_dir/powerlevel10k"
  else
    echo "✔️ Powerlevel10k theme is already installed."
  fi

  if [ ! -d "$plugins_dir/zsh-syntax-highlighting" ]; then
    echo "⏳ Installing plugin: zsh-syntax-highlighting."
    echo ""
    git clone -q --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$plugins_dir/zsh-syntax-highlighting"
  else
    echo "✔️ zsh-syntax-highlighting plugin is already installed."
  fi
}

main
