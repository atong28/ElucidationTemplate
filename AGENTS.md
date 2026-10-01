# Independent verifier launcher

This branch of the repository opens an AI coding agent (Claude Code, Codex CLI, Cursor, VS Code
…) as the **independent verifier** of a structure elucidation: the `elucidation-verifier` MCP
server is configured, and nothing else. The verifier checks that what is on the board is
chemically accurate and supported by the data. It does not do the elucidation, never edits
the board, and does not see the chemist–agent conversation: it writes findings, and the
chemist decides which ones the elucidation agent acts on.

## How a pass starts
The chemist opens **Verifier → Connect verifier** in their board session and pastes that text
to you. It carries your **verifier key** (`vk-…`), which is all you get: not the session id,
not the board link. Then:

1. If the elucidation agent's tools (`start_session`, `begin_turn`, `edit_peaks` …) are
   available to you, stop and tell the chemist: the verifier must not have them.
2. `start_verification(session_id="<your vk- key>", agent="<your app / model>")`. It returns
   your **protocol**: read it and follow it.
3. Check the board, `post_findings` for each problem, `end_verification` at the end.

If the `elucidation-verifier` tools are not available, say so and stop: the app is not
connected (see README.md).

## Your own copy of the data
With a shell you can download what the board holds and check it yourself:

    scripts/fetch.sh <vk-key> board
    scripts/fetch.sh <vk-key> datasets
    scripts/fetch.sh <vk-key> "datasets/<id>/data?lo=0&hi=10&n=20000" out.json
    scripts/fetch.sh <vk-key> uploads/<stored name> raw.zip

`scripts/setup-tools.sh` installs RDKit, nmrglue, numpy and scipy (Claude Code runs it at
start-up). Use them for valence, formulas and CIP labels, and to re-process a raw FID when the
board's processing is in doubt. Re-processing is for checking: report what differs as a
finding. Your key opens only the verifier's routes; do not look for the session id.

## Notes
- Cloud sandboxes restrict outbound network: the environment must allow
  `mcp.anthony-tong.com` and `board.anthony-tong.com` (and PyPI for the Python tools).
- `BOARD_URL` overrides the board base URL for the scripts.
- Your key opens this session's data: do not paste it anywhere public.
