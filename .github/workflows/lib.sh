#!/usr/bin/env bash

# Shared functions for slide build scripts.

# Compute content hash of a *_slides/ directory.
# Excludes generated files (node_modules, dist).
content_hash() {
  local dir="$1"
  find "$dir" -type f \
    -not -path '*/node_modules/*' \
    -not -path '*/dist/*' \
    | sort | xargs sha256sum | sha256sum | cut -d' ' -f1
}
