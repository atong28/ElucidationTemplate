#!/usr/bin/env bash
# Create a board session and print its id and link.
#   scripts/new-session.sh "working title"
set -euo pipefail
BOARD="${BOARD_URL:-https://board.anthony-tong.com}"
TITLE="${1:-Untitled elucidation}"
resp=$(curl -sS -X POST "$BOARD/api/sessions" -H 'content-type: application/json' \
  --data "$(printf '{"title": %s}' "$(printf '%s' "$TITLE" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))')")")
sid=$(printf '%s' "$resp" | python3 -c 'import json,sys; print(json.load(sys.stdin)["session_id"])')
echo "session_id: $sid"
echo "board:      $BOARD/?session=$sid"
