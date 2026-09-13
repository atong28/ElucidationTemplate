# Elucidation launcher

A minimal repository whose only job is to open **Claude Code** (web or local) with the
structure-elucidation connector configured and two helper scripts on the path. It is not
a workspace: nothing you put here is tracked, and nothing runs here. The board, the
chemistry tools and the raw-spectra processing are on the ElucidationSandbox server.

## Use it
1. Create a repository from this template (or just clone it).
2. Open it in Claude Code. On the web, allow outbound access to `mcp.anthony-tong.com`
   and `board.anthony-tong.com` in the environment settings.
3. Type `/elucidate`. Tell the agent where your data is: a local path, a URL, or a session
   where you already attached it on the board. The agent uploads it to the board session
   and processes it server-side, then hands you the board link.

## What is here
- `.mcp.json` — the connector (28 tools: chemistry, board, raw spectra).
- `scripts/new-session.sh` — create a session, print id and link.
- `scripts/upload.sh <session> <file|dir|url> [note]` — get data onto the board chat in one
  call, which is the only way the server-side tools can see it.
- `CLAUDE.md` / `.claude/commands/elucidate.md` — the agent's instructions; the full protocol
  is fetched live from `https://mcp.anthony-tong.com/prompt`.

Self-hosted server: set `BOARD_URL` for the scripts and edit the `url` in `.mcp.json`.
