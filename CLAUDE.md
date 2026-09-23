# Elucidation launcher

This repository exists only so Claude Code opens with the structure-elucidation connector
(`.mcp.json` → `elucidation`) and an upload script in place. It is not a workspace: nothing
placed here is tracked and no state is kept. The board, the chemistry tools and all spectra
processing live on the server.

## How a session starts
Sessions start **on the board** (https://board.anthony-tong.com). The chemist creates one,
uploads their data there, clicks **Connect agent** and pastes that text to you. It carries the
session id. Then:

1. `start_session(session_id="<id from the pasted text>")`. It returns the operating
   **protocol**: read it and follow it for the whole session.
2. `begin_turn(session_id, focus_phase)` → work the phases → `end_turn(...)`, every turn.

If the chemist starts you without that text, ask them to create the session on the board and
paste its Connect-agent text. Only if they insist on starting here: `start_session(title=...)`
creates an empty session, and you give them its board link.

## The one rule about data
The tools see only what is uploaded to the session. Files on this machine, in this
conversation or at a URL are invisible to the server until uploaded:

    scripts/upload.sh <session_id> <file | directory | URL> "<what it is>"

Directories are zipped, URLs downloaded, nested zips opened server-side. After an upload,
`list_datasets` catalogues and processes the spectra. Never process instrument files by hand.
Peak lists in any format (text, exports, images or PDFs of SI tables): upload them, read them
with `read_upload` and record them with `import_peak_list`.

## Notes
- Claude Code on the web restricts outbound network; the environment must allow
  `mcp.anthony-tong.com` and `board.anthony-tong.com`.
- `BOARD_URL` overrides the board base URL for the scripts.
- Session links are public behind an unguessable id; do not paste them anywhere public.
