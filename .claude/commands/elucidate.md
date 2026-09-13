Start (or resume) the elucidation for the data in `data/`.

1. List `data/` (recursively, names and sizes only) and summarise what the chemist supplied.
2. Fetch the protocol: run `curl -s https://mcp.anthony-tong.com/prompt` and follow it.
3. If no session exists yet (check `SESSION.md` in the repo root), call `start_session` with a
   short working title, write the id and board link to `SESSION.md`, and tell the chemist the link.
   If `SESSION.md` exists, adopt that session with `start_session(session_id=...)`.
4. If the board chat has no attachments yet (`get_board_state` → chat[]), run
   `scripts/upload.sh <session_id> data "<what it is>"`, then `list_spectra`.
5. Continue with the protocol: process, pick, post, conclude the round, wait for the chemist.
