#!/usr/bin/env bash
# Python tools for the verifier's own checks: RDKit (valence, formulas, CIP labels) and nmrglue
# with numpy / scipy (re-processing a raw FID, fitting lines). Claude Code runs this as a
# SessionStart hook; other agents run it by hand (AGENTS.md). Quiet when all are there.
mods="rdkit nmrglue numpy scipy"
python3 -c "import rdkit, nmrglue, numpy, scipy" 2>/dev/null && exit 0
for args in "-q" "-q --user" "-q --break-system-packages"; do
  python3 -m pip install $args $mods >/dev/null 2>&1 && python3 -c "import rdkit, nmrglue, numpy, scipy" 2>/dev/null && {
    echo "RDKit $(python3 -c 'import rdkit; print(rdkit.__version__)'), nmrglue, numpy and scipy installed for this session."; exit 0; }
done
echo "Could not install $mods: this environment's network must allow pypi.org and" \
     "files.pythonhosted.org (Custom access listing the board hosts, with 'Also include default" \
     "list of common package managers' ticked). The verifier's board tools still work."
exit 0
