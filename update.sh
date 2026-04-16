#!/usr/bin/env bash
# Updates the GitHub Pages report from the parity verification pipeline.
# Usage: ./update.sh [path-to-html]
#
# If no path is given, defaults to the standard pipeline output location.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DEFAULT_SRC="${SCRIPT_DIR}/../att-worktrees/dcore-sorch-parity/deployable/disputes-core/PARITY-VERIFICATION.html"

SRC="${1:-$DEFAULT_SRC}"

if [[ ! -f "$SRC" ]]; then
    echo "Error: source file not found: $SRC"
    echo "Usage: $0 [path-to-PARITY-VERIFICATION.html]"
    exit 1
fi

cp "$SRC" "${SCRIPT_DIR}/index.html"

cd "$SCRIPT_DIR"
git add index.html
git commit -m "Update parity report $(date +%Y-%m-%d_%H:%M)"
git push origin main
echo "Done. Report updated and pushed."
