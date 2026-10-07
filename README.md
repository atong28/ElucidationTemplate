# Independent verifier launcher (branch `verifier`)

This branch opens an AI coding agent as the **independent verifier** of a structure
elucidation on the Elucidation Board. Only the `elucidation-verifier` server is configured.
The elucidation agent itself runs from the `main` branch, in a separate session. If your
account also has the agent's connector (claude.ai connectors appear in Claude Code sessions),
the verifier leaves those tools alone; it holds only a verifier key, so they could not reach
the session anyway.

The verifier checks the board against the data and posts findings, which the chemist accepts
or dismisses on the session's Verifier tab. It never edits the board and never sees the
chemist–agent conversation. It is given a verifier key, not the session id, so it cannot read
the conversation through the board's web API either.

The full setup guide is on the board: https://board.anthony-tong.com/?page=setup&role=verifier

## Recommended: Claude Code on the web, from your own fork
Each session runs in its own container, so the verifier shares nothing with the agent's
session, and it has a shell to download whole spectra and raw instrument files and check them
with its own code.

1. **Fork** https://github.com/atong28/ElucidationTemplate on GitHub, unticking **Copy the
   `main` branch only** so the fork has this branch.
2. At https://claude.ai/code, use an environment with network access **Custom**: allowed
   domains `mcp.anthony-tong.com` and `board.anthony-tong.com`, with **Also include default
   list of common package managers** ticked.
3. Start a session on your fork's **`verifier`** branch and paste the board's
   **Verifier → Connect verifier** text (or `/verify <text>`).

## Other apps
- **Claude Code** (terminal or IDE): `git checkout verifier` in a clone used only for the
  verifier; the server is in `.mcp.json`; `/mcp` shows it.
- **Codex CLI**: run `codex` in that clone and trust the folder; `.codex/config.toml` adds the
  server. Keep the agent's `elucidation` server out of `~/.codex/config.toml`.
- **Cursor** / **VS Code**: `.cursor/mcp.json` / `.vscode/mcp.json`.

## What is here
- `AGENTS.md` — the verifier's instructions (`CLAUDE.md` imports it). Its full protocol comes
  from the server with `start_verification`.
- `.mcp.json`, `.codex/config.toml`, `.cursor/mcp.json`, `.vscode/mcp.json` — the
  `elucidation-verifier` server for each app.
- `scripts/fetch.sh <vk-key> <path> [out]` — download from the verifier's read-only data
  routes (board, datasets, spectra, raw files).
- `scripts/setup-tools.sh` — installs RDKit, nmrglue, numpy and scipy (a SessionStart hook in
  Claude Code).
- `.claude/commands/verify.md` — the `/verify` command.

Self-hosted server: set `BOARD_URL` for the scripts and change the URL in the four config files.
