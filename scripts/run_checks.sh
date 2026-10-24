#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
while IFS= read -r -d '' f; do bash -n "$f"; done < <(find "$ROOT" -type f -name '*.sh' -print0)
python3 -m py_compile \
  "$ROOT/04-python/healthcheck.py" "$ROOT/04-python/log_summary.py" \
  "$ROOT/04-python/sre_healthcheck.py" "$ROOT/04-python/log_analyzer.py" \
  "$ROOT/10-sre/slo_calculator.py"
(cd "$ROOT" && PYTHONPATH="$ROOT" python3 -m unittest discover -s tests -v)
PYTHONPATH="$ROOT/04-python" python3 -m unittest discover -s "$ROOT/04-python" -p 'test_*.py' -v
PYTHONPATH="$ROOT/10-sre" python3 -m unittest discover -s "$ROOT/10-sre" -p 'test_*.py' -v
printf '\nAll Bash syntax checks and Python unit tests passed.\n'
