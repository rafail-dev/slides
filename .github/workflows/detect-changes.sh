#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/lib.sh"

# Detect which *_slides/ presentations changed since last deploy.
# Outputs: space-separated names, "__all__" if no cache, "__none__" if nothing changed.

changed=""
has_cache=false

for dir in *_slides/; do
  name="${dir%_slides/}"
  hash=$(content_hash "$dir")
  cached_hash=""
  if [ -f "_site/$name/.content-hash" ]; then
    cached_hash=$(cat "_site/$name/.content-hash")
    has_cache=true
  fi

  if [ "$hash" != "$cached_hash" ]; then
    changed="$changed $name"
  fi
done

if [ -n "$changed" ]; then
  echo "$changed" | xargs
elif [ "$has_cache" = true ]; then
  echo "__none__"
else
  echo "__all__"
fi
