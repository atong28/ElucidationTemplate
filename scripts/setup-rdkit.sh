#!/usr/bin/env bash
# Make RDKit importable for the agent's own checks (SMILES, stereo, atom order). Claude Code
# runs this as a SessionStart hook; other agents run it by hand (AGENTS.md). Quiet when it is
# already there; one line of context when it cannot be installed.
python3 -c "import rdkit" 2>/dev/null && exit 0
for args in "-q rdkit" "-q --user rdkit" "-q --break-system-packages rdkit"; do
  python3 -m pip install $args >/dev/null 2>&1 && python3 -c "import rdkit" 2>/dev/null && {
    echo "RDKit $(python3 -c 'import rdkit; print(rdkit.__version__)') installed for this session."; exit 0; }
done
echo "RDKit could not be installed: this environment's network must allow pypi.org and" \
     "files.pythonhosted.org (Custom access listing the board hosts, with 'Also include default" \
     "list of common package managers' ticked). The board's own chemistry tools still work."
exit 0
