#!/usr/bin/env bash
#
# This script will add some finishing touches.
#

set -euo pipefail

make_folders() {
  echo "📁 Creating folders (if doesn't exists) - ~/Code."
  echo ""
  mkdir -p ~/Code
}

show_instructions() {
  echo "📋 Next steps for you."
  echo ""
  echo "👉 [iterm2]   Load settings from ~/.config/iterm2 (iterm2 Settings > General > Settings)."
  echo "👉 [Config]   Inspect your configuration files."
}

main() {
  make_folders
  show_instructions
}

main
