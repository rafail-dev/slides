#!/usr/bin/env bash
set -euo pipefail

# Detect which *_slides/ presentations changed since last deploy.
# Outputs space-separated list of names (without _slides suffix),
# or "__all__" if all should be rebuilt.

if [ -f _site/.deployed-sha ]; then
  prev=$(cat _site/.deployed-sha)
  changed=$(git diff --name-only "$prev" HEAD -- '*_slides/' \
    | cut -d/ -f1 | sort -u | sed 's/_slides$//' | tr '\n' ' ')
  echo "${changed:-__all__}"
else
  echo "__all__"
fi
