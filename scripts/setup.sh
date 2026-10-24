#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
DATA_DIR="${SRE_LAB_DATA_DIR:-$ROOT/data}"
mkdir -p "$DATA_DIR"/{logs,cases,reports,snapshots,artifacts}
if [[ ! -f "$DATA_DIR/logs/petclinic_sample.log" ]]; then
  cat > "$DATA_DIR/logs/petclinic_sample.log" <<'LOG'
2026-10-24T09:00:01Z INFO gateway request_id=a1 path=/owners status=200 latency_ms=42
2026-10-24T09:00:02Z INFO gateway request_id=a2 path=/vets status=200 latency_ms=38
2026-10-24T09:00:03Z INFO gateway request_id=a3 path=/visits status=200 latency_ms=51
2026-10-24T09:01:05Z WARN gateway request_id=a4 path=/owners status=503 latency_ms=2001 upstream=customers-service
2026-10-24T09:01:07Z ERROR gateway request_id=a5 path=/owners status=503 latency_ms=2002 error="upstream timeout"
2026-10-24T09:01:09Z ERROR gateway request_id=a6 path=/owners status=503 latency_ms=2004 error="upstream timeout"
2026-10-24T09:02:11Z INFO gateway request_id=a7 path=/vets status=200 latency_ms=47
LOG
fi
cat > "$DATA_DIR/notes.txt" <<'NOTE'
Persistent learning happens in GitHub Markdown files, not in this transient data directory.
Do not store secrets or real production data here. Use synthetic logs only.
NOTE
printf 'Lab workspace ready: %s\n' "$DATA_DIR"
printf 'Next: ./labctl.sh baseline\n'
printf 'Then: ./labctl.sh case disk_inodes && ./labctl.sh diagnose\n\n'
for c in bash date uname uptime free df ps ip ss curl git python3 docker podman kubectl journalctl systemctl terraform ansible-playbook; do
  if command -v "$c" >/dev/null 2>&1; then printf 'FOUND   %-18s %s\n' "$c" "$(command -v "$c")"; else printf 'MISSING %-18s (not needed for every lab)\n' "$c"; fi
done
