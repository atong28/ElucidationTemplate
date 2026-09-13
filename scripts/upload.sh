#!/usr/bin/env bash
# Upload instrument data to a board session so the server-side tools can see it.
#   scripts/upload.sh <session_id> <file-or-directory> [note]
# A directory is zipped first (top-level folder kept). A file is sent as-is.
set -euo pipefail
BOARD="${BOARD_URL:-https://board.anthony-tong.com}"
SID="${1:?session id}"; SRC="${2:?file or directory}"; NOTE="${3:-}"
if [ -d "$SRC" ]; then
  name="$(basename "$SRC")"
  tmp="$(mktemp -d)"; zip_path="$tmp/$name.zip"
  (cd "$(dirname "$SRC")" && zip -qr "$zip_path" "$name" -x '*/.*' '__MACOSX/*')
  SRC="$zip_path"
fi
size=$(stat -c %s "$SRC" 2>/dev/null || stat -f %z "$SRC")
if [ "$size" -gt $((250 * 1024 * 1024)) ]; then
  echo "too large ($size bytes); the board accepts 250 MB per attachment — split the bundle" >&2; exit 1
fi
curl -sS -F "file=@$SRC" ${NOTE:+-F "note=$NOTE"} "$BOARD/api/sessions/$SID/uploads?post=1"
echo
