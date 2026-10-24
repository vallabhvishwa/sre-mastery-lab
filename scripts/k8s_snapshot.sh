#!/usr/bin/env bash
set -uo pipefail
NS="${1:-}"
if ! command -v kubectl >/dev/null 2>&1; then echo 'kubectl is not installed in this playground.' >&2; exit 127; fi
if ! kubectl config current-context 2>/dev/null; then echo 'No active Kubernetes context. Connect to a disposable lab cluster first.' >&2; exit 2; fi
printf 'READ-ONLY Kubernetes snapshot. Context: '; kubectl config current-context
if [[ -n "$NS" ]]; then
  printf 'Namespace: %s\n' "$NS"
  echo '--- Pods'; kubectl -n "$NS" get pods -o wide 2>&1 || true
  echo '--- Deployments'; kubectl -n "$NS" get deployments 2>&1 || true
  echo '--- Services'; kubectl -n "$NS" get services 2>&1 || true
  echo '--- Recent namespace events'; kubectl -n "$NS" get events --sort-by=.metadata.creationTimestamp 2>&1 | tail -n 50 || true
  echo '--- Pod summaries (no Secret objects are requested)'
  while IFS= read -r pod; do
    [[ -z "$pod" ]] && continue
    echo "### pod/$pod"
    kubectl -n "$NS" describe pod "$pod" 2>&1 | tail -n 80 || true
    echo '## Current logs (tail 80)'; kubectl -n "$NS" logs "$pod" --all-containers=true --tail=80 2>&1 || true
    echo '## Previous logs (tail 80)'; kubectl -n "$NS" logs "$pod" --all-containers=true --previous --tail=80 2>&1 || true
  done < <(kubectl -n "$NS" get pods -o name 2>/dev/null | sed 's#^pod/##')
else
  echo 'Usage: ./labctl.sh k8s-snapshot <lab-namespace>'
  echo 'A namespace is required to avoid broad collection from a cluster.'
  exit 2
fi
