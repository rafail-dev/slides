#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/lib.sh"

# Build Slidev presentations.
# Usage: build-slides.sh <changed> <base_path>
#   changed  - space-separated names, "__all__", or "__none__"
#   base_path - repo name for --base (e.g. "slides")

changed="$1"
base_path="$2"

if [ "$changed" = "__none__" ]; then
  echo "No changes detected, skipping all builds"
  exit 0
fi

for dir in *_slides/; do
  name="${dir%_slides/}"

  if [ "$changed" != "__all__" ] && ! echo "$changed" | grep -qw "$name"; then
    echo "Skipping $name (unchanged)"
    continue
  fi

  echo "Building $dir → $name"
  cd "$dir"
  bun install --frozen-lockfile
  bunx slidev build --base "/$base_path/$name/"
  cd ..
  mkdir -p _site/"$name"
  cp -r "$dir/dist/"* _site/"$name"/
  content_hash "$dir" > _site/"$name"/.content-hash
done
