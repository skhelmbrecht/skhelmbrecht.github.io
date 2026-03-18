#!/usr/bin/env bash
# Converts static/docs/resume.pdf to static/images/resume.png
# Replaces white background with #FDFBD4 to match site theme
# Requires: pdftoppm (from poppler-utils), magick (from ImageMagick)

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PDF="$REPO_ROOT/static/docs/resume.pdf"
OUT="$REPO_ROOT/static/images/resume.png"

if [ ! -f "$PDF" ]; then
  echo "Error: $PDF not found" >&2
  exit 1
fi

pdftoppm -png -r 300 -singlefile "$PDF" "${OUT%.png}"
magick "$OUT" -fill '#FEFEE9' -opaque white "$OUT"
echo "Created $OUT"
