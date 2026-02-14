#!/usr/bin/env bash
#
# Runs all setup scripts in sequence
#
# Environment variables (can be overridden):
#   REMOTE_REPO - Git remote repository URL (default: https://github.com/jigarjain/sutradhar)
#   LOCAL_REPO - Local repository path (default: $HOME/Code/sutradhar)
#

set -euo pipefail

: "${REMOTE_REPO:="https://github.com/jigarjain/sutradhar"}"
: "${LOCAL_REPO:="$HOME/Code/sutradhar"}"

export REMOTE_REPO LOCAL_REPO

main() {
  local root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  local scripts_dir="$root_dir/scripts"

  if [ ! -d "$scripts_dir" ]; then
    echo "🛑 scripts directory not found."
    exit 1
  fi

  echo "🚀 Fasten your seat belt."
  echo ""

  for script in "$scripts_dir"/*.sh; do
    echo "▶ Executing $(basename "$script"):"
    echo ""
    bash "$script"
    echo ""
    echo ""
  done

  echo "🎉 All Done."
}

main
