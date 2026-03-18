#!/usr/bin/env bash
# Generates a circle-cropped favicon from static/images/profile.jpg
# Outputs favicon.ico (multi-size) and favicon-192.png for web manifest
# Requires: magick (from ImageMagick)

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$REPO_ROOT/static/images/profile.jpg"
OUT_DIR="$REPO_ROOT/static/favicon"
mkdir -p "$OUT_DIR"

if [ ! -f "$SRC" ]; then
  echo "Error: $SRC not found" >&2
  exit 1
fi

# Create a 512x512 circle-cropped intermediate
magick "$SRC" -resize 512x512^ -gravity center -extent 512x512 \
  \( -size 512x512 xc:none -fill white -draw "circle 256,256 256,0" \) \
  -compose CopyOpacity -composite \
  "$OUT_DIR/favicon-512.png"

# Generate sizes for .ico (16, 32, 48) and a 192px for web manifest
magick "$OUT_DIR/favicon-512.png" -resize 192x192 "$OUT_DIR/favicon-192.png"
magick "$OUT_DIR/favicon-512.png" -resize 32x32 "$OUT_DIR/favicon-32.png"
magick "$OUT_DIR/favicon-512.png" \
  \( -clone 0 -resize 16x16 \) \
  \( -clone 0 -resize 32x32 \) \
  \( -clone 0 -resize 48x48 \) \
  -delete 0 "$OUT_DIR/favicon.ico"

rm "$OUT_DIR/favicon-512.png"
echo "Created $OUT_DIR/favicon.ico, favicon-32.png, favicon-192.png"
