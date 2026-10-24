#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
DATA_DIR="${SRE_LAB_DATA_DIR:-$ROOT/data}"
CASE="${1:-}"
CASE_DIR="$DATA_DIR/cases"
mkdir -p "$CASE_DIR"
if [[ -z "$CASE" ]]; then echo 'Usage: ./labctl.sh case <case-name>' >&2; exit 2; fi
OUT="$CASE_DIR/current.log"
case "$CASE" in
http_5xx) cat >"$OUT" <<'LOG'
2026-10-24T09:12:00Z INFO gateway request_id=a1 path=/owners status=200 latency_ms=42
2026-10-24T09:12:03Z INFO gateway request_id=a2 path=/vets status=200 latency_ms=51
2026-10-24T09:12:07Z WARN gateway request_id=a3 path=/owners status=503 latency_ms=2001 upstream=customers-service
2026-10-24T09:12:09Z ERROR gateway request_id=a4 path=/owners status=503 latency_ms=2000 error="upstream response timeout"
2026-10-24T09:12:11Z ERROR gateway request_id=a5 path=/owners status=503 latency_ms=2002 error="upstream response timeout"
2026-10-24T09:12:14Z INFO gateway request_id=a6 path=/vets status=200 latency_ms=49
2026-10-24T09:12:17Z ERROR gateway request_id=a7 path=/owners status=503 latency_ms=2003 error="upstream response timeout"
LOG
;;
dns) cat >"$OUT" <<'LOG'
2026-10-24T10:00:01Z INFO visits-service starting
2026-10-24T10:00:02Z ERROR visits-service discovery lookup failed hostname=discovery-server error="temporary failure in name resolution"
2026-10-24T10:00:05Z WARN visits-service retry attempt=1 delay_ms=500
2026-10-24T10:00:06Z ERROR visits-service lookup failed hostname=discovery-server error="Name or service not known"
2026-10-24T10:00:10Z ERROR gateway request_id=b1 status=502 error="no healthy upstream"
LOG
;;
dependency_latency) cat >"$OUT" <<'LOG'
2026-10-24T11:20:00Z INFO gateway request_id=c1 path=/owners status=200 latency_ms=65
2026-10-24T11:20:02Z WARN gateway request_id=c2 path=/owners status=200 latency_ms=1850 upstream=customers-service
2026-10-24T11:20:04Z WARN customers-service dependency=database operation=select latency_ms=1720
2026-10-24T11:20:06Z WARN gateway request_id=c3 path=/owners status=504 latency_ms=3000 error="gateway timeout"
2026-10-24T11:20:08Z WARN customers-service dependency=database operation=select latency_ms=2900
LOG
;;
oom) cat >"$OUT" <<'LOG'
2026-10-24T12:30:00Z INFO customers-service startup complete
2026-10-24T12:31:10Z WARN customers-service memory_used_mb=890 memory_limit_mb=900
2026-10-24T12:31:14Z ERROR customers-service allocation_failed requested_mb=64
2026-10-24T12:31:15Z WARN customers-service restart_count=1
2026-10-24T12:31:22Z ERROR gateway upstream=customers-service error="connection reset by peer"
LOG
;;
disk_blocks) cat >"$OUT" <<'LOG'
2026-10-24T13:05:00Z INFO node filesystem=/var usage_percent=71 inode_percent=42
2026-10-24T13:10:00Z WARN node filesystem=/var usage_percent=94 inode_percent=45
2026-10-24T13:14:00Z ERROR log-writer path=/var/log/app.log error="No space left on device"
2026-10-24T13:14:02Z ERROR app write_temp_file path=/tmp/request.tmp error="No space left on device"
2026-10-24T13:14:04Z WARN healthcheck result=failed reason="write failed"
LOG
;;
disk_inodes) cat >"$OUT" <<'LOG'
2026-10-24T13:05:00Z INFO node filesystem=/var usage_percent=71 inode_percent=42
2026-10-24T13:10:00Z WARN node filesystem=/var usage_percent=74 inode_percent=97
2026-10-24T13:11:00Z ERROR node create_file path=/var/cache/app/item-983 error="No space left on device"
2026-10-24T13:12:00Z INFO node filesystem=/var usage_percent=75 inode_percent=99
2026-10-24T13:13:00Z ERROR app write_temp_file error="No space left on device"
LOG
;;
permissions) cat >"$OUT" <<'LOG'
2026-10-24T14:00:00Z INFO deployment started user=runner
2026-10-24T14:00:01Z ERROR deployment script path=./deploy.sh error="Permission denied"
2026-10-24T14:00:02Z ERROR registry auth credentials_file=/home/runner/.config/registry/config.json error="Permission denied"
2026-10-24T14:00:03Z WARN deployment status=failed
LOG
;;
certificate) cat >"$OUT" <<'LOG'
2026-10-24T15:00:00Z INFO gateway tls_handshake=success
2026-10-24T15:01:00Z WARN gateway certificate_days_remaining=2 hostname=api.lab.invalid
2026-10-24T15:02:00Z ERROR client tls_handshake=failed reason="certificate has expired"
2026-10-24T15:02:01Z ERROR gateway request_id=tls-19 status=0 error="remote error: tls: bad certificate"
LOG
;;
cpu_saturation) cat >"$OUT" <<'LOG'
2026-10-24T16:00:00Z INFO api request_rate_rps=120 latency_p95_ms=90
2026-10-24T16:01:00Z WARN api request_rate_rps=240 latency_p95_ms=440
2026-10-24T16:02:00Z WARN node cpu_busy_percent=97 run_queue=18
2026-10-24T16:03:00Z ERROR api request_rate_rps=260 latency_p95_ms=1800 status=503
2026-10-24T16:04:00Z ERROR api timeout_count=85
LOG
;;
bad_rollout) cat >"$OUT" <<'LOG'
2026-10-24T17:00:00Z INFO deploy release=v1.8.1 healthy_replicas=6 desired_replicas=6
2026-10-24T17:02:00Z INFO deploy release=v1.8.2 started desired_replicas=6
2026-10-24T17:02:30Z WARN deploy release=v1.8.2 ready_replicas=2 desired_replicas=6
2026-10-24T17:03:00Z ERROR deploy release=v1.8.2 readiness_failures=4
2026-10-24T17:03:20Z ERROR api release=v1.8.2 status=503 rate_percent=18
2026-10-24T17:04:00Z WARN deploy release=v1.8.2 rollback_available=true
LOG
;;
retry_storm) cat >"$OUT" <<'LOG'
2026-10-24T18:00:00Z INFO api request_rate_rps=100 retry_rate_rps=10
2026-10-24T18:01:00Z WARN dependency p95_ms=1200 timeout_ms=1000
2026-10-24T18:01:05Z WARN api retry_attempt=1 backoff_ms=0
2026-10-24T18:01:10Z ERROR dependency connection_pool_active=100 max=100
2026-10-24T18:02:00Z ERROR api request_rate_rps=110 retry_rate_rps=180 status=503
LOG
;;
queue_lag) cat >"$OUT" <<'LOG'
2026-10-24T19:00:00Z INFO consumer topic=visits partition=0 lag=120
2026-10-24T19:01:00Z WARN consumer topic=visits partition=0 lag=1400
2026-10-24T19:02:00Z WARN producer topic=visits publish_rate_rps=180
2026-10-24T19:02:10Z ERROR consumer topic=visits processing_rate_rps=75 error_count=35
2026-10-24T19:03:00Z ERROR consumer topic=visits partition=0 lag=12000
LOG
;;
clock_skew) cat >"$OUT" <<'LOG'
2026-10-24T20:00:00Z INFO api node=node-a event_time=20:00:00Z
2026-10-24T20:00:02Z ERROR auth token_validation node=node-b error="token not yet valid"
2026-10-24T20:00:03Z WARN node=node-b ntp_offset_seconds=87
2026-10-24T20:00:04Z ERROR logs node=node-b timestamp=2026-10-24T19:58:37Z message="event order inconsistent"
LOG
;;
*) echo "Unknown case: $CASE" >&2; echo 'Cases: http_5xx dns dependency_latency oom disk_blocks disk_inodes permissions certificate cpu_saturation bad_rollout retry_storm queue_lag clock_skew' >&2; exit 2;;
esac
printf '%s\n' "$CASE" > "$CASE_DIR/current_case"
printf 'Created synthetic case: %s\nEvidence log: %s\n' "$CASE" "$OUT"
printf 'Try ./labctl.sh diagnose; then record impact, hypotheses, test, mitigation, validation and prevention.\n'
