Run an independent verification pass on a structure-elucidation board.

1. The start is the text the chemist copies from the board's **Verifier → Connect verifier**
   button; it carries your verifier key (vk-…). If $ARGUMENTS or the conversation contains it,
   use that key. If not, ask the chemist for that text.
2. If the elucidation agent's tools (`start_session`, `begin_turn` …) are also available
   (an account-wide connector), never call them; carry on with the `elucidation-verifier`
   tools.
3. Call `start_verification(session_id=<key>, agent="Claude Code / <model>")`. It returns your
   protocol: follow it.
4. Check the board against the data, post each problem with `post_findings`, and end with
   `end_verification`.
