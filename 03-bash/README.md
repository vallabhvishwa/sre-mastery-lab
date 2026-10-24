# Bash for production-quality automation

Learn quoting, `set -uo pipefail` (understand `errexit` edge cases), args, functions, traps, temp files, `mktemp`, `trap` cleanup, exit codes, timeouts, retries, logging and idempotence.

## Drill: write a safe health checker

Requirements:
- accepts URL and timeout as arguments;
- rejects missing/invalid inputs;
- uses a bounded timeout and no infinite retries;
- sends no credentials by default;
- emits timestamp + URL + result + elapsed time;
- returns 0 only on healthy success; nonzero on failure;
- can be rerun; never changes system state.

## Drill: log summary

Read a provided file, count `ERROR`, `WARN`, HTTP 5xx, and top endpoints. Handle missing file, empty file and malformed lines. Avoid parsing structured logs with fragile whitespace assumptions; explain when `jq` is better.

## Review checklist

- Is every variable quoted unless intentional splitting is needed?
- Are secrets kept out of logs?
- Are timeouts present?
- Does failure propagate via exit code?
- Is the action idempotent or explicitly guarded?
- Does cleanup run on exit / interruption?
- Could a failed command be silently ignored?
