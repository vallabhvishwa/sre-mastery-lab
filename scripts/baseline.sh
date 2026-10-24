#!/usr/bin/env bash
set -uo pipefail
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
DATA_DIR="${SRE_LAB_DATA_DIR:-$ROOT/data}"
mkdir -p "$DATA_DIR/snapshots"
OUT="$DATA_DIR/snapshots/baseline-$(date -u +%Y%m%dT%H%M%SZ).txt"
run() {
  local label="$1"; shift
  printf '\n===== %s =====\n' "$label"
  if command -v "$1" >/dev/null 2>&1; then "$@" 2>&1 || true; else printf 'Unavailable: %s\n' "$1"; fi
}
{
  printf 'READ-ONLY SRE BASELINE\nUTC: '; date -u '+%Y-%m-%dT%H:%M:%SZ'
  run 'Host / kernel' uname -a
  run 'Uptime / load average' uptime
  run 'CPU count' nproc
  run 'Memory' free -h
  run 'Filesystem capacity' df -hT
  run 'Inode capacity' df -ih
  run 'Top CPU processes' ps -eo pid,ppid,stat,%cpu,%mem,etime,comm --sort=-%cpu
  run 'Top memory processes' ps -eo pid,ppid,stat,%cpu,%mem,etime,comm --sort=-%mem
  run 'Open file limits' sh -c 'ulimit -n; printf "\n/proc/sys/fs/file-nr: "; cat /proc/sys/fs/file-nr 2>/dev/null || true'
  run 'Listening sockets' ss -lntup
  run 'Addresses' ip address show
  run 'Routes' ip route show
  run 'Resolver config' cat /etc/resolv.conf
  run 'Recent kernel messages (permissions may restrict)' dmesg --ctime
  run 'Recent journal (permissions may restrict)' journalctl -n 50 --no-pager
  if command -v systemctl >/dev/null 2>&1; then
    for svc in ssh sshd nginx docker containerd kubelet; do run "systemd status: $svc" systemctl --no-pager --full status "$svc"; done
  fi
} | tee "$OUT"
printf '\nSnapshot saved to %s\nThis script is intended to be read-only. Permission-denied output is normal in restricted labs.\n' "$OUT"
