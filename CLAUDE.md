# Elucidation launcher

This repository exists only so a chemist can open Claude Code with the structure
elucidation connector and the upload scripts in place. It is not a workspace: nothing
placed here is tracked, and no state is kept between sessions. The board, the chemistry
tools and all raw-spectra processing live on a remote server reached through the
`elucidation` MCP connector (`.mcp.json`) and the board's HTTP API.

## The one rule about data
The server only processes what is **attached in the board chat**. Files in this
conversation, on this machine or at a URL are invisible to it until uploaded with
`scripts/upload.sh`. Never process instrument files by hand and never guess peak lists
from file contents: upload, then use the tools.

## Flow (`/elucidate` runs it)
1. Fetch the current operating protocol and follow it: `curl -s https://mcp.anthony-tong.com/prompt`
2. Session: if the chemist gives a session id, adopt it with `start_session(session_id=...)`;
   otherwise create one with `start_session` (or `scripts/new-session.sh "<title>"`) and
   tell them the link `https://board.anthony-tong.com/?session=<id>`.
3. Data: ask where it is if not obvious. Then
   `scripts/upload.sh <session_id> <file | directory | URL> "<short description>"`.
   Directories are zipped, URLs downloaded, nested zips opened server-side.
4. `list_spectra` → `process_spectrum` → `pick_peaks` → `view_spectrum` / `fit_region` /
   `tabulate_peaks`; post peak tables; work round by round; every turn opens a round and
   ends with `conclude_round`.

## Notes
- Claude Code on the web restricts outbound network; the environment must allow
  `mcp.anthony-tong.com` and `board.anthony-tong.com`.
- `BOARD_URL` overrides the board base URL for the scripts.
- Session links are public behind an unguessable id; do not paste them anywhere public.
