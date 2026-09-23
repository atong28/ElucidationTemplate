#!/usr/bin/env bash
# Upload data to a board session so the server-side tools can see it (logged as the agent's upload).
#   scripts/upload.sh <session_id> <file | directory | URL> [note]
# A directory is zipped first (top-level folder kept). A URL is downloaded first.
# A file is sent as-is. Zips inside zips are fine; the server opens them.
set -euo pipefail
BOARD="${BOARD_URL:-https://board.anthony-tong.com}"
SID="${1:?session id}"; SRC="${2:?file, directory or URL}"; NOTE="${3:-}"
tmp="$(mktemp -d)"
case "$SRC" in
  http://*|https://*)
    name="$(basename "${SRC%%\?*}")"; [ -n "$name" ] || name="download.zip"
    curl -sSL -o "$tmp/$name" "$SRC"; SRC="$tmp/$name" ;;
esac
if [ -d "$SRC" ]; then
  name="$(basename "$SRC")"; zip_path="$tmp/$name.zip"
  (cd "$(dirname "$SRC")" && zip -qr "$zip_path" "$name" -x '*/.*' '__MACOSX/*')
  SRC="$zip_path"
fi
size=$(stat -c %s "$SRC" 2>/dev/null || stat -f %z "$SRC")
if [ "$size" -gt $((250 * 1024 * 1024)) ]; then
  echo "too large ($size bytes); the board accepts 250 MB per attachment — split it" >&2; exit 1
fi
curl -sS -F "file=@$SRC" ${NOTE:+-F "note=$NOTE"} "$BOARD/api/sessions/$SID/uploads?author=agent"
echo
