@AGENTS.md

## Claude Code specifics
- The connector is in `.mcp.json`; `/mcp` should list `elucidation-verifier` and nothing else
  from the board.
- A SessionStart hook (`.claude/settings.json`) runs `scripts/setup-tools.sh`.
- `/verify <Connect-verifier text>` starts a pass.
- Claude Code on the web: the environment needs Custom network access listing
  `mcp.anthony-tong.com` and `board.anthony-tong.com`, with "Also include default list of
  common package managers" ticked (PyPI, for the Python tools).
