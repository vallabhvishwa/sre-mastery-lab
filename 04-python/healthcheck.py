#!/usr/bin/env python3
"""Small stdlib-only URL health checker for SRE practice.

Usage: python3 04-python/healthcheck.py https://example.com --timeout 3
No credentials are added. Network access depends on your environment.
"""
from __future__ import annotations
import argparse
import json
import sys
import time
import urllib.error
import urllib.request
from datetime import datetime, timezone


def check_url(url: str, timeout: float) -> dict:
    started = time.monotonic()
    request = urllib.request.Request(url, headers={"User-Agent": "sre-lab-healthcheck/1.0"})
    try:
        with urllib.request.urlopen(request, timeout=timeout) as response:
            code = response.getcode()
            ok = 200 <= code < 400
            result = {"url": url, "ok": ok, "status": code}
    except urllib.error.HTTPError as exc:
        result = {"url": url, "ok": False, "status": exc.code, "error": "http_error"}
    except (urllib.error.URLError, TimeoutError, OSError) as exc:
        result = {"url": url, "ok": False, "error": type(exc).__name__, "detail": str(exc)}
    result["elapsed_ms"] = round((time.monotonic() - started) * 1000, 2)
    result["timestamp_utc"] = datetime.now(timezone.utc).isoformat()
    return result


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("url", help="URL to check; use only endpoints you are authorized to access")
    parser.add_argument("--timeout", type=float, default=3.0, help="request timeout in seconds (default: 3)")
    args = parser.parse_args()
    if args.timeout <= 0 or args.timeout > 60:
        parser.error("--timeout must be between 0 and 60 seconds")
    result = check_url(args.url, args.timeout)
    print(json.dumps(result, indent=2))
    return 0 if result["ok"] else 1

if __name__ == "__main__":
    sys.exit(main())
