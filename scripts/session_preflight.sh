#!/usr/bin/env bash
set -uo pipefail
printf '=== SRE Lab Session Preflight ===\n'
printf 'UTC: '; date -u '+%Y-%m-%dT%H:%M:%SZ'
printf 'Host: '; hostname 2>/dev/null || true
printf 'User: '; id 2>/dev/null || true
for c in bash git python3 go docker podman kubectl helm terraform ansible curl jq ip ss free df ps systemctl journalctl; do
 if command -v "$c" >/dev/null 2>&1; then printf 'FOUND %-12s %s\n' "$c" "$(command -v "$c")"; else printf 'MISS  %-12s\n' "$c"; fi
done
printf '\n=== OS ===\n'; cat /etc/os-release 2>/dev/null || uname -a
printf '\n=== Resource baseline ===\n'; uptime 2>/dev/null || true; free -h 2>/dev/null || true; df -h 2>/dev/null || true
printf '\nSafety: verify you are in the assigned disposable playground before creating or changing resources.\n'
