# Elucidation launcher

A minimal repository whose only job is to open an AI coding agent (**Claude Code**, **Codex
CLI**, **Cursor** or **VS Code**) with the structure-elucidation server configured and an
upload script on the path. It is not a workspace: nothing you put here is tracked and nothing
runs here. The board, the chemistry tools and the spectra processing run on the Elucidation
Board server.

The full, per-app setup guide (including chat apps like Claude and ChatGPT, which do not need
this repository) is on the board: https://board.anthony-tong.com/?page=setup

## Use it
1. On https://board.anthony-tong.com, create a session and upload your data (zipped
   instrument folders, JCAMP-DX, mzML / MGF, IR / UV exports, peak lists).
2. Open this repository in your agent:
   - **Claude Code** (terminal or IDE): the server is in `.mcp.json`; `/mcp` shows it.
   - **Claude Code on the web**: the environment's network access must be **Custom**, listing
     `mcp.anthony-tong.com` and `board.anthony-tong.com` under **Allowed domains**, with **Also
     include default list of common package managers** ticked (PyPI, for RDKit). A
     SessionStart hook (`scripts/setup-rdkit.sh`) installs RDKit. Optional: put
     `pip install rdkit` in the environment's **Setup script** so it is cached.
   - **Codex CLI**: run `codex` here and answer **yes** when it asks whether to trust the
     folder; `.codex/config.toml` then adds the server with a 300 s tool timeout and
     pre-approved board tools. (Without trust, add the same section to `~/.codex/config.toml`.)
   - **Cursor** / **VS Code**: `.cursor/mcp.json` / `.vscode/mcp.json`.
3. On the board, click **Connect agent**, copy the text and paste it into the agent (in Claude
   Code, `/elucidate` followed by the text also works). The agent adopts your session, receives
   its protocol from the server and works the board phase by phase. The board header shows
   which app and model are working.

## What is here
- `AGENTS.md` — the agent's instructions (read by Codex, Cursor and others); `CLAUDE.md`
  imports it and adds the Claude Code specifics. The full protocol comes from the server when
  the agent adopts a session.
- `.mcp.json`, `.codex/config.toml`, `.cursor/mcp.json`, `.vscode/mcp.json` — the
  `elucidation` server for each app.
- `scripts/upload.sh <session> <file|dir|url> [note]` — upload data to a session.
- `scripts/new-session.sh` — create an empty session from the command line (the board is the
  usual way).
- `scripts/setup-rdkit.sh` — installs RDKit (a SessionStart hook in Claude Code; run it by hand
  elsewhere).
- `.claude/commands/elucidate.md` — the `/elucidate` command.

Self-hosted server: set `BOARD_URL` for the scripts and change the URL in the four config files.
