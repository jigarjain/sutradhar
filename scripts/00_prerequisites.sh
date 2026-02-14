#!/usr/bin/env bash
#
# This script prepares the environment by confirming whether command line tools
# are available. If not, then it will attempt to install it (xcode-select).
#
set -euo pipefail

TOOLS=(git curl python3 clang)

is_tool_available() {
  command -v "$1" >/dev/null 2>&1
}

check_tools() {
  local missing=0

  echo "🔍 Checking required tools."

  for tool in "${TOOLS[@]}"; do
    if is_tool_available "$tool"; then
      echo "✔️ $tool"
    else
      echo "❓$tool"
      missing=1
    fi
  done

  echo ""
  return $missing
}

main() {
  if check_tools; then
    return
  fi

  echo "⏳ Installing Command Line Tools."
  echo ""

  xcode-select --install || true

  echo "⏳ Waiting for tools."
  echo ""

  until check_tools; do
    sleep 5
  done
}

main
