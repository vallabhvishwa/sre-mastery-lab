#!/usr/bin/env bash
# Read-only Kubernetes triage capture. Verify context before running.
set -uo pipefail
if ! command -v kubectl >/dev/null 2>&1; then echo 'kubectl unavailable'; exit 2; fi
CTX="$(kubectl config current-context 2>/dev/null || true)"
printf 'Current context: %s\n' "${CTX:-UNKNOWN}"
if [[ -z "$CTX" ]]; then echo 'No active context; stopping.'; exit 2; fi
read -r -p "Type the exact context name to confirm this is your disposable lab: " CONFIRM
if [[ "$CONFIRM" != "$CTX" ]]; then echo 'Context mismatch; no commands executed.'; exit 2; fi
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
OUT="${SRE_LAB_DATA_DIR:-$ROOT/data}/snapshots/k8s-triage-$(date -u +%Y%m%dT%H%M%SZ).txt"
mkdir -p "$(dirname "$OUT")"
{
  echo "Kubernetes triage snapshot UTC: $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  echo "Context: $CTX"
  echo '\n## Nodes'; kubectl get nodes -o wide 2>&1 || true
  echo '\n## Pods'; kubectl get pods -A -o wide 2>&1 || true
  echo '\n## Deployments'; kubectl get deploy -A 2>&1 || true
  echo '\n## Services/endpoints'; kubectl get svc,ep -A 2>&1 || true
  echo '\n## Recent events'; kubectl get events -A --sort-by=.lastTimestamp 2>&1 || true
} | tee "$OUT"
echo "Saved read-only evidence to $OUT"
