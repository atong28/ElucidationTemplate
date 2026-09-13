Run a structure elucidation on the board.

1. Fetch the protocol with `curl -s https://mcp.anthony-tong.com/prompt` and follow it.
2. Ask the chemist for a session id if they have one; otherwise call `start_session` with a short
   working title and tell them the board link `https://board.anthony-tong.com/?session=<id>`.
3. Ask where the data is (a path, a URL, or already attached on the board). If it is not on the
   board yet (`get_board_state` → chat[] has no attachments), run
   `scripts/upload.sh <session_id> <path-or-url> "<what it is>"`, then `list_spectra`.
4. Continue with the protocol: process, pick, post, conclude the round, wait for the chemist.
