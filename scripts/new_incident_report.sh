#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
DATA_DIR="${SRE_LAB_DATA_DIR:-$ROOT/data}"
mkdir -p "$DATA_DIR/reports"
STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
OUT="$DATA_DIR/reports/incident-$STAMP.md"
cp "$ROOT/runbooks/incident_template.md" "$OUT"
printf '\nCreated report template: %s\nFill it in before reading scenarios/answer_key.md. Copy a sanitized version into your GitHub notebook when done.\n' "$OUT"
