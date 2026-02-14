#!/usr/bin/env bash
#
# Helper methods to be imported by other scripts
#

require_var() {
  local name="$1"
  [ -n "${!name:-}" ] || {
    echo "🛑 Missing exported variable: $name"
    echo "Please EXPORT $name with correct value."
    exit 1
  }
}
