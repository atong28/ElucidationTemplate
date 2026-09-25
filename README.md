# Elucidation launcher

A minimal repository whose only job is to open **Claude Code** (web or local) with the
structure-elucidation connector configured and an upload script on the path. It is not a
workspace: nothing you put here is tracked and nothing runs here. The board, the chemistry
tools and the spectra processing run on the Elucidation Board server.

## Use it
1. On https://board.anthony-tong.com, create a session and upload your data (zipped
   instrument folders, JCAMP-DX, MS reports, peak lists).
2. Open this repository in Claude Code. On the web, the environment's network access must
   reach the board and PyPI: choose **Custom**, list `mcp.anthony-tong.com` and
   `board.anthony-tong.com` under **Allowed domains**, and tick **Also include default list of
   common package managers** (PyPI, conda, npm …). A SessionStart hook
   (`scripts/setup-rdkit.sh`) then installs RDKit so the agent can check SMILES and
   stereochemistry itself. Optional: put `pip install rdkit` in the environment's
   **Setup script** so it is cached instead of installed per session.
3. On the board, click **Connect agent**, copy the text and paste it into Claude Code (or run
   `/elucidate` and paste it). The agent adopts your session, receives its protocol from the
   server and works the board phase by phase.

The same pasted text also works in a claude.ai chat with the `elucidation` connector
(`https://mcp.anthony-tong.com/mcp`) enabled; this launcher adds a shell, so the agent can
upload data you point it at on your machine.

## What is here
- `.mcp.json` — the `elucidation` connector.
- `scripts/upload.sh <session> <file|dir|url> [note]` — upload data to a session.
- `scripts/new-session.sh` — create an empty session from the command line (the board is the
  usual way).
- `scripts/setup-rdkit.sh` + `.claude/settings.json` — SessionStart hook that installs RDKit.
- `CLAUDE.md` / `.claude/commands/elucidate.md` — the agent's instructions; the full protocol
  comes from the server when the agent adopts a session.

Self-hosted server: set `BOARD_URL` for the scripts and edit the `url` in `.mcp.json`.
