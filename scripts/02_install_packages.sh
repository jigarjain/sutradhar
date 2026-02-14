#!/usr/bin/env bash
#
# This script installs Homebrew & packages from ../Brewfile.* based
# on your selected profile
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

install_packages() {
  local brewfile_common="$REPO_ROOT/Brewfile.common"
  local brewfile_personal="$REPO_ROOT/Brewfile.personal"
  local brewfile_work="$REPO_ROOT/Brewfile.work"
  local files=("$brewfile_common")

  while true; do
    echo "👉 Select profile for package installation:"
    echo "  p) Personal"
    echo "  w) Work"
    echo "  b) Both"
    echo "  n) None (will still install common packages)"

    read -rp "Choice [p/w/b/n]: " choice

    case "$choice" in
      p|P)
        files+=("$brewfile_personal")
        break
        ;;
      w|W)
        files+=("$brewfile_work")
        break
        ;;
      b|B)
        files+=("$brewfile_personal" "$brewfile_work")
        break
        ;;
      n|N)
        break
        ;;
      *)
        echo "🚫 Invalid choice — try again."
        ;;
    esac
  done

  brew update
  echo ""

  echo "⚠️ Some package installations needs sudo access."
  sudo -v
  echo ""

  for f in "${files[@]}"; do
    echo "⏳ Installing packages from $(basename "$f"):"
    brew bundle --file "$f"
    echo "✔️ Packages from $(basename "$f") installed."
    echo ""
  done
}


main() {
  local brew_bin="/opt/homebrew/bin/brew"

  if [ ! -x "$brew_bin" ]; then
    echo "⏳ Installing Homebrew."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "✔️ Homebrew already installed."
  fi

  if [ ! -x "$brew_bin" ]; then
    echo "🛑 Homebrew installation failed."
    exit 1
  fi

  echo "⚙️ Activating brew environment."
  echo ""

  eval "$("$brew_bin" shellenv)"

  install_packages
}

main
