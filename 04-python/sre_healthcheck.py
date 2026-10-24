#!/usr/bin/env python3
"""Small, dependency-free HTTP health checker for services you own or are authorized to test."""
from __future__ import annotations
import argparse
import json
import time
import urllib.error
import urllib.request
from dataclasses import asdict, dataclass
from typing import Sequence

@dataclass
class ProbeResult:
    url: str
    ok: bool
    status: int | None
    latency_ms: float
    attempts: int
    error: str | None = None


def probe_once(url: str, timeout: float, expected: set[int]) -> tuple[bool, int | None, float, str | None]:
    request = urllib.request.Request(url, headers={"User-Agent": "sre-mastery-lab/1.0"}, method="GET")
    started = time.monotonic()
    try:
        with urllib.request.urlopen(request, timeout=timeout) as response:
            status = response.status
            response.read(1024)  # Bound data read; this is a health probe, not a downloader.
        latency = (time.monotonic() - started) * 1000
        return status in expected, status, latency, None if status in expected else f"unexpected HTTP status {status}"
    except urllib.error.HTTPError as exc:
        latency = (time.monotonic() - started) * 1000
        return exc.code in expected, exc.code, latency, None if exc.code in expected else f"HTTP {exc.code}"
    except (urllib.error.URLError, TimeoutError, OSError) as exc:
        latency = (time.monotonic() - started) * 1000
        reason = getattr(exc, "reason", exc)
        return False, None, latency, str(reason)


def check_url(url: str, timeout: float = 3.0, retries: int = 2, expected: set[int] | None = None, backoff: float = 0.25) -> ProbeResult:
    if timeout <= 0:
        raise ValueError("timeout must be > 0")
    if retries < 0 or retries > 10:
        raise ValueError("retries must be between 0 and 10")
    expected = expected or {200, 201, 202, 204}
    last: tuple[bool, int | None, float, str | None] = (False, None, 0.0, "no attempt")
    total_latency = 0.0
    for attempt in range(1, retries + 2):
        last = probe_once(url, timeout, expected)
        total_latency += last[2]
        if last[0]:
            return ProbeResult(url, True, last[1], total_latency, attempt)
        if attempt <= retries:
            time.sleep(min(backoff * (2 ** (attempt - 1)), 2.0))
    return ProbeResult(url, False, last[1], total_latency, retries + 1, last[3])


def parse_expected(value: str) -> set[int]:
    try:
        codes = {int(part.strip()) for part in value.split(",") if part.strip()}
    except ValueError as exc:
        raise argparse.ArgumentTypeError("Expected status codes must be comma-separated integers") from exc
    if not codes or any(code < 100 or code > 599 for code in codes):
        raise argparse.ArgumentTypeError("Status codes must be in the range 100-599")
    return codes


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("url", help="URL of a service you own or are authorized to probe")
    parser.add_argument("--timeout", type=float, default=3.0, help="Per-attempt timeout in seconds (default: 3)")
    parser.add_argument("--retries", type=int, default=2, help="Retries after first attempt (0-10; default: 2)")
    parser.add_argument("--expected", type=parse_expected, default={200, 201, 202, 204}, help="Expected HTTP status codes, e.g. 200,204")
    parser.add_argument("--json", action="store_true", help="Print machine-readable JSON")
    args = parser.parse_args(argv)
    try:
        result = check_url(args.url, args.timeout, args.retries, args.expected)
    except ValueError as exc:
        parser.error(str(exc))
    if args.json:
        print(json.dumps(asdict(result), sort_keys=True))
    else:
        status = result.status if result.status is not None else "no-http-response"
        print(f"{'PASS' if result.ok else 'FAIL'} url={result.url} status={status} latency_ms={result.latency_ms:.1f} attempts={result.attempts}")
        if result.error:
            print(f"reason={result.error}")
    return 0 if result.ok else 1

if __name__ == "__main__":
    raise SystemExit(main())
