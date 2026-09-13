# Elucidation template

A starter repository for running a chemist-in-the-loop NMR structure elucidation in
**Claude Code** (web or local). Nothing runs here: the board, the chemistry tools and the
raw-spectra processing are on the ElucidationSandbox server, reached through the MCP
connector in `.mcp.json` and the board's HTTP API. This repo holds your data and tells
the agent how to use them.

## Use it
1. **Use this template** → create your own (private) repository from it.
2. Put your data in `data/` (see `data/README.md`): raw Bruker/Varian folders, zipped or
   not, JCAMP-DX, CSV exports, peak lists, images, notes. No structures or names.
3. Open the repository in Claude Code. On the web, allow outbound access to
   `mcp.anthony-tong.com` and `board.anthony-tong.com` in the environment settings.
4. Type `/elucidate`. The agent creates a board session, uploads `data/` to it, processes the
   spectra server-side, and gives you the board link. Review and reply on the board; the
   agent picks your feedback up each round.

## What the agent does
- Fetches the live protocol from `https://mcp.anthony-tong.com/prompt` (not vendored here,
  so it cannot drift from the server).
- `scripts/new-session.sh` creates a session; `scripts/upload.sh` zips and posts your data
  to the board chat in one call — that is what makes it visible to the server-side tools.
- Processing, peak picking, deconvolution and curation all happen on the server
  (`list_spectra`, `process_spectrum`, `pick_peaks`, `view_spectrum`, `fit_region`,
  `tabulate_peaks`). The agent never parses instrument files itself.

## Self-hosted server
Set `BOARD_URL` for the scripts and edit the `url` in `.mcp.json`.
