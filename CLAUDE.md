# Structure elucidation from this repository

This repo is a workspace for one compound. The chemist has put their data in `data/`.
You run a chemist-in-the-loop NMR structure elucidation on a shared board; the board,
the chemistry tools and the raw-spectra processing all live on a remote server reached
through the `elucidation` MCP connector (`.mcp.json`) and the board's HTTP API.

## The one rule about data
The server can only process what is **attached in the board chat**. Files in this repo,
or in this conversation, are invisible to it until uploaded. Never process instrument
files by hand and never guess peak lists from file contents — upload, then use the tools.

## Start (`/elucidate` does these steps)
1. Read `data/` to learn what is there (formats, experiments, notes). Do not open raw
   binary files; a directory listing plus any notes is enough.
2. Fetch the current operating protocol and follow it for the rest of the session:
   `curl -s https://mcp.anthony-tong.com/prompt`
3. Create a board session with the connector's `start_session` tool (or
   `scripts/new-session.sh "<title>"`). Tell the chemist the board link:
   `https://board.anthony-tong.com/?session=<session_id>`.
4. Upload the data: `scripts/upload.sh <session_id> data "<short description>"`.
   This zips the directory and posts it to the board chat in one call.
5. `list_spectra` → `process_spectrum` → `pick_peaks` → `view_spectrum` / `fit_region` /
   `tabulate_peaks`, then post peak tables and work round by round as the protocol says.
   Every turn opens a round and ends with `conclude_round`.

## Environment notes
- Claude Code on the web restricts outbound network by default. The environment must
  allow `mcp.anthony-tong.com` and `board.anthony-tong.com`.
- `BOARD_URL` overrides the board base URL for the scripts (self-hosted deployments).
- Sessions are public behind an unguessable id; do not paste session links anywhere public.
