@AGENTS.md

## Claude Code specifics
- The connector is in `.mcp.json`; `/mcp` shows whether it is connected.
- A SessionStart hook (`.claude/settings.json`) runs `scripts/setup-rdkit.sh`.
- `/elucidate <Connect-agent text>` starts a session.
- Claude Code on the web: the environment needs Custom network access listing
  `mcp.anthony-tong.com` and `board.anthony-tong.com`, with "Also include default list of
  common package managers" ticked (PyPI, for RDKit).
