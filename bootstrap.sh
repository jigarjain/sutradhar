#!/usr/bin/env bash
#
# Remote bootstrap installer. Needs git & curl pre-installed on your system.
# For local bootstrap installer, see `run_scripts.sh`
#
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/jigarjain/sutradhar/HEAD/bootstrap.sh)"
#

set -euo pipefail

: "${REMOTE_REPO:="https://github.com/jigarjain/sutradhar"}"
: "${LOCAL_REPO:="$HOME/Code/sutradhar"}"

export REMOTE_REPO LOCAL_REPO

main() {
  local base_dir="$(dirname "$LOCAL_REPO")"

  command -v git >/dev/null || {
    echo "🛑 git is required."
    exit 1
  }

  echo "📁 Preparing install directory."
  mkdir -p "$base_dir"

  if [ ! -d "$LOCAL_REPO/.git" ]; then
    echo "⏳ Cloning remote repository."
    git clone -q "$REMOTE_REPO" "$LOCAL_REPO"
  else
    echo "✔️ Repository already present."
  fi

  echo ""
  echo ""
  cd "$LOCAL_REPO"
  bash run_scripts.sh
}

main
