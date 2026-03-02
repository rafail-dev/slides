#!/usr/bin/env bash
set -euo pipefail

# Build Slidev presentations.
# Usage: build-slides.sh <changed> <base_path>
#   changed  - space-separated names or "__all__"
#   base_path - repo name for --base (e.g. "slides")

changed="$1"
base_path="$2"

for dir in *_slides/; do
  name="${dir%_slides/}"

  if [ "$changed" != "__all__" ] && ! echo "$changed" | grep -qw "$name"; then
    echo "Skipping $name (unchanged)"
    continue
  fi

  echo "Building $dir → $name"
  cd "$dir"
  bun install
  bunx slidev build --base "/$base_path/$name/"
  cd ..
  mkdir -p _site/"$name"
  cp -r "$dir/dist/"* _site/"$name"/
  # Save content hash for future change detection (must match detect-changes.sh)
  find "$dir" -type f \
    -not -path '*/node_modules/*' \
    -not -path '*/dist/*' \
    -not -name 'bun.lock*' \
    -not -name '*.lockb' \
    | sort | xargs sha256sum | sha256sum | cut -d' ' -f1 > _site/"$name"/.content-hash
done
