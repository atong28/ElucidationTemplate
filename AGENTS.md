# Elucidation launcher

This repository exists only so an AI coding agent (Claude Code, Codex CLI, Cursor, VS Code …)
opens with the structure-elucidation MCP server (`elucidation`) configured and an upload
script in place. It is not a workspace: nothing placed here is tracked and no state is kept.
The board, the chemistry tools and all spectra processing live on the server.

This branch connects the **elucidation agent**. The independent verifier is a separate agent
with its own branch (`verifier`) and server (`elucidation-verifier`): if its tools
(`start_verification`, `post_findings` …) are available to you as well, stop and tell the
chemist, because the two must not share a session.

## How a session starts
Sessions start **on the board** (https://board.anthony-tong.com). The chemist creates one,
uploads their data there, clicks **Connect agent** and pastes that text to you. It carries the
session id. Then:

1. `start_session(session_id="<id from the pasted text>", agent="<your app / model>")`, e.g.
   agent="Codex CLI / gpt-5.5" or "Claude Code / Claude Opus". It returns the operating
   **protocol**: read it and follow it for the whole session.
2. `begin_turn(session_id, focus_phase)` → work the phases → `end_turn(...)`, every turn.

If the `elucidation` tools are not available to you, say so and stop: the app is not
connected (see README.md). If the chemist starts you without the Connect-agent text, ask them
to create the session on the board and paste it. Only if they insist on starting here:
`start_session(title=...)` creates an empty session, and you give them its board link.

## The one rule about data
The tools see only what is uploaded to the session. Files on this machine, in this
conversation or at a URL are invisible to the server until uploaded:

    scripts/upload.sh <session_id> <file | directory | URL> "<what it is>"

Directories are zipped, URLs downloaded, nested zips opened server-side. After an upload,
`list_datasets` catalogues and processes the spectra (NMR, MS, IR, UV). Never process
instrument files by hand. Peak lists and reported data in any format (text, exports, images
or PDFs of SI tables): upload them, read them with `read_upload`, and record them with
`import_peak_list` or `import_reported_data`.

## RDKit for your own checks
If `python3 -c "import rdkit"` fails, run `scripts/setup-rdkit.sh` once (Claude Code runs it
by itself at start-up). If it cannot install RDKit, tell the chemist; do not work around it by
hand-editing structures. The board's own chemistry tools work either way.

## Notes
- Cloud sandboxes restrict outbound network: the environment must allow
  `mcp.anthony-tong.com` and `board.anthony-tong.com` (and PyPI for RDKit).
- `BOARD_URL` overrides the board base URL for the scripts.
- Session links are public behind an unguessable id; do not paste them anywhere public.
