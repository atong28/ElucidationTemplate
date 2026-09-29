Run a structure elucidation on the board.

1. The canonical start is the text the chemist copies from the board's **Connect agent**
   button; it carries the session id. If $ARGUMENTS or the conversation contains it, use that id.
   If not, ask the chemist to create the session on https://board.anthony-tong.com, upload their
   data there and paste the Connect-agent text. (Only if they insist on starting here:
   `start_session(title=...)` and give them the board link it returns.)
2. Call `start_session(session_id=..., agent="Claude Code / <model>")`. It returns the
   operating protocol: follow it for the whole session.
3. If the chemist points you at data that is not on the board yet (a local path or URL), upload
   it first: `scripts/upload.sh <session_id> <path-or-url> "<what it is>"`.
4. `begin_turn` → work the phases the data serves → `end_turn` with your question and the next
   experiment. Then wait for the chemist.
