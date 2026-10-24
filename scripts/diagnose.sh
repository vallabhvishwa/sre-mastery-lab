#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
DATA_DIR="${SRE_LAB_DATA_DIR:-$ROOT/data}"
LOG_FILE="$DATA_DIR/cases/current.log"
if [[ ! -f "$LOG_FILE" ]]; then echo 'No active case. Run ./labctl.sh case <name> first.' >&2; exit 1; fi
printf 'SYNTHETIC INCIDENT: Evidence collection only. This script does not reveal the answer.\n\n'
printf 'Lines: '; wc -l < "$LOG_FILE"
printf 'ERROR rows: '; (grep -cE '(^| )ERROR( |$)' "$LOG_FILE" || true)
printf 'WARN rows: '; (grep -cE '(^| )WARN( |$)' "$LOG_FILE" || true)
printf '\n-- Error/warning candidates --\n'; grep -Ein 'error|exception|failed|timeout|permission|space|memory|restart|unhealthy|resolution|lag|certificate|cpu|retry|ready_replicas|offset' "$LOG_FILE" || true
printf '\n-- Status frequency --\n'; grep -Eo 'status=[0-9]+' "$LOG_FILE" | sort | uniq -c | sort -nr || true
printf '\n-- Latencies --\n'; grep -Eo 'latency_ms=[0-9]+' "$LOG_FILE" | cut -d= -f2 | sort -n | awk 'BEGIN{n=0;sum=0} {a[NR]=$1;sum+=$1;n++} END{if(n){printf "samples=%d mean_ms=%.1f max_ms=%d\n",n,sum/n,a[n]; idx=int((n*95+99)/100); printf "p95_nearest_rank_ms=%d\n",a[idx]}}' || true
printf '\n-- Full synthetic log --\n'; cat "$LOG_FILE"
printf '\nBefore next step, write two hypotheses and one low-risk test in a report. Do not guess the root cause from one line alone.\n'
