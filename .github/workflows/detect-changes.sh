#!/usr/bin/env bash
set -euo pipefail

# Detect which *_slides/ presentations changed since last deploy.
# Compares content hash of each dir against cached hash — no git history needed.
# Outputs space-separated list of changed names, or "__all__" if none cached.

changed=""

for dir in *_slides/; do
  name="${dir%_slides/}"
  hash=$(find "$dir" -type f -not -path '*/node_modules/*' -not -path '*/dist/*' | sort | xargs sha256sum | sha256sum | cut -d' ' -f1)
  cached_hash=""
  [ -f "_site/$name/.content-hash" ] && cached_hash=$(cat "_site/$name/.content-hash")

  if [ "$hash" != "$cached_hash" ]; then
    changed="$changed $name"
  fi
done

echo "${changed:- __all__}" | xargs
