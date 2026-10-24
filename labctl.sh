#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cmd="${1:-help}"
shift || true
case "$cmd" in
  help|-h|--help)
    cat <<'HELP'
SRE Mastery Lab — one playground / one focused 60-minute session

Usage:
  ./labctl.sh setup
  ./labctl.sh preflight
  ./labctl.sh baseline
  ./labctl.sh case <http_5xx|dns|dependency_latency|oom|disk_blocks|disk_inodes|permissions|certificate|cpu_saturation|bad_rollout|retry_storm|queue_lag|clock_skew>
  ./labctl.sh diagnose
  ./labctl.sh report
  ./labctl.sh k8s-snapshot <lab-namespace>
  ./labctl.sh healthcheck <authorized-URL> [--timeout 3] [--retries 2] [--json]
  ./labctl.sh analyze <logfile>
  ./labctl.sh slo --total 2000000 --bad 1400 --slo 99.9
  ./labctl.sh test

All synthetic logs/reports go into gitignored ./data by default. Baseline and
Kubernetes snapshot are read-only. Use disposable environments only.
HELP
    ;;
  setup) bash "$ROOT/scripts/setup.sh" ;;
  preflight) bash "$ROOT/scripts/session_preflight.sh" ;;
  baseline) bash "$ROOT/scripts/baseline.sh" ;;
  case) bash "$ROOT/scripts/caseforge.sh" "${1:-}" ;;
  diagnose) bash "$ROOT/scripts/diagnose.sh" ;;
  report) bash "$ROOT/scripts/new_incident_report.sh" ;;
  k8s-snapshot) bash "$ROOT/scripts/k8s_snapshot.sh" "${1:-}" ;;
  healthcheck) python3 "$ROOT/04-python/sre_healthcheck.py" "$@" ;;
  analyze) [[ -n "${1:-}" ]] || { echo 'Usage: ./labctl.sh analyze <logfile>' >&2; exit 2; }; python3 "$ROOT/04-python/log_analyzer.py" "${1}" --json ;;
  slo) shift 0; python3 "$ROOT/10-sre/slo_calculator.py" "$@" ;;
  test) (cd "$ROOT" && bash scripts/run_checks.sh) ;;
  session) echo 'Choose exactly one card from sessions/PLAYGROUND_SESSION_CARDS.md and follow docs/ONE_HOUR_PROTOCOL.md.' ;;
  *) echo "Unknown command: $cmd" >&2; echo 'Run ./labctl.sh help' >&2; exit 2 ;;
esac
