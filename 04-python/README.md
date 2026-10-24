# Python for SRE automation

Use Python for repeatable diagnostic tools, API clients, log processing and validation. For the first pass, avoid third-party dependencies so the lab works even when package installation is blocked.

## Exercises

1. Run `python3 04-python/log_summary.py ~/sre-lab/logs/app.log`.
2. Run tests: `python3 -m unittest discover -s python -p 'test_*.py'`.
3. Try `python3 04-python/healthcheck.py https://example.com --timeout 3` only if outbound network is allowed. A sandbox block is not necessarily your code failing.
4. Add command-line options for JSON output and a non-zero failure threshold.
5. Add structured logging, unit tests for HTTP errors/timeouts, and bounded retries with backoff+jitter.
6. Build a deployment validator that tests a health endpoint after a release and exits non-zero if the result is unhealthy.

## Code quality gate

- Inputs validated; no secrets in source or logs.
- Explicit timeout for every network call.
- Clear exceptions and nonzero exit status on failure.
- Unit tests cover success, failure, timeout, malformed input and missing files.
- `README` describes scope, usage, limitations and safe operation.
- No call to an infrastructure API that changes resources unless specifically authorized and guarded.
