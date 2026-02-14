#!/usr/bin/env bash
#
# This script update dotfiles based from `../configs` folder using `chezmoi`.
# It WILL overwrite any existing configs. That shouldn't matter on fresh
# install. But if running on an already configured system, ensure dot_files are
# added/updated in `../configs`
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

source "$REPO_ROOT/helpers.sh"

require_var REMOTE_REPO
require_var LOCAL_REPO

main() {
  local base_dir="$(dirname "$LOCAL_REPO")"

  if ! command -v chezmoi >/dev/null; then
    echo "🛑 chezmoi not found."
    exit 1
  fi

  if [ ! -d "$base_dir" ]; then
    echo "📁 Creating $base_dir."
    echo ""
    mkdir -p "$base_dir"
  fi

  if [ ! -d "$LOCAL_REPO/.git" ]; then
    echo "⏳ Cloning remote repository."
    echo ""
    git clone -q "$REMOTE_REPO" "$LOCAL_REPO"
  else
    echo "✔️ Repo already present."
  fi

  echo "⚙️ Applying configurations."
  echo ""
  chezmoi init --source "$LOCAL_REPO" --apply
  echo ""
  echo "✔️ Configuration applied."
}

main
