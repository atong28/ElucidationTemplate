#!/usr/bin/env bash
# Download from the verifier's read-only data routes (your verifier key, never a session id).
#   scripts/fetch.sh <vk-key> <path> [out-file]
#   scripts/fetch.sh vk-… board                       the board in brief (JSON)
#   scripts/fetch.sh vk-… datasets                    datasets, conditions, runs
#   scripts/fetch.sh vk-… "datasets/1H/data?lo=0&hi=10&n=20000" h1.json
#   scripts/fetch.sh vk-… "runs/1H.r1/complex" h1.bin  float32 re/im pairs
#   scripts/fetch.sh vk-… uploads/<stored name> raw.zip   (the url listed in board → uploads)
set -euo pipefail
BOARD="${BOARD_URL:-https://board.anthony-tong.com}"
KEY="${1:?verifier key (vk-…)}"; P="${2:?path, e.g. board}"; OUT="${3:-}"
case "$KEY" in vk-*) ;; *) echo "that is not a verifier key (vk-…): copy it from the Connect-verifier text" >&2; exit 1 ;; esac
P="${P#/}"; P="${P#api/verify/$KEY/}"
if [ -n "$OUT" ]; then curl -fsSL --compressed -o "$OUT" "$BOARD/api/verify/$KEY/$P" && echo "$OUT"
else curl -fsSL --compressed "$BOARD/api/verify/$KEY/$P"; echo; fi
