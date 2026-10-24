#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
bash "$ROOT/01-linux/setup.sh"
printf '\nStarter tools ready. Next: bash scripts/session_preflight.sh, then bash 01-linux/baseline.sh\n'
printf 'For synthetic incidents: bash "$ROOT/labctl.sh" case http_5xx\n'
