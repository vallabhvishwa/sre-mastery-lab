#!/usr/bin/env python3
"""Summarize common level/status/latency fields in synthetic or authorized logs."""
from __future__ import annotations
import argparse
import json
import re
import sys
from collections import Counter
from pathlib import Path
from typing import Iterable

LEVEL_RE = re.compile(r"\b(DEBUG|INFO|WARN|WARNING|ERROR|CRITICAL|FATAL)\b")
STATUS_RE = re.compile(r"\bstatus[=:](\d{3})\b", re.IGNORECASE)
LATENCY_RE = re.compile(r"\b(?:latency_ms|duration_ms|response_time_ms)[=:](\d+(?:\.\d+)?)\b", re.IGNORECASE)
PATH_RE = re.compile(r"\bpath=([^\s]+)")

def percentile(values: list[float], p: float) -> float | None:
    if not values:
        return None
    ordered = sorted(values)
    # Nearest-rank percentile: rank = ceil(p*n), with 1-based indexing.
    rank = max(1, min(len(ordered), int((p * len(ordered) + 99) // 100)))
    return ordered[rank - 1]

def analyze_lines(lines: Iterable[str]) -> dict:
    levels: Counter[str] = Counter()
    statuses: Counter[str] = Counter()
    paths: Counter[str] = Counter()
    latencies: list[float] = []
    total = 0
    error_examples: list[str] = []
    for line in lines:
        line = line.rstrip("\n")
        if not line:
            continue
        total += 1
        level_match = LEVEL_RE.search(line)
        if level_match:
            level = level_match.group(1).upper()
            if level == "WARNING":
                level = "WARN"
            levels[level] += 1
            if level in {"ERROR", "CRITICAL", "FATAL"} and len(error_examples) < 5:
                error_examples.append(line[:500])
        for match in STATUS_RE.finditer(line):
            statuses[match.group(1)] += 1
        for match in LATENCY_RE.finditer(line):
            latencies.append(float(match.group(1)))
        path_match = PATH_RE.search(line)
        if path_match:
            paths[path_match.group(1)] += 1
    total_statuses = sum(statuses.values())
    server_errors = sum(n for code, n in statuses.items() if code.startswith("5"))
    client_errors = sum(n for code, n in statuses.items() if code.startswith("4"))
    return {
        "lines": total,
        "levels": dict(sorted(levels.items())),
        "statuses": dict(sorted(statuses.items())),
        "requests_with_status": total_statuses,
        "http_4xx": client_errors,
        "http_5xx": server_errors,
        "http_5xx_rate_percent": round(server_errors / total_statuses * 100, 2) if total_statuses else None,
        "latency_samples": len(latencies),
        "latency_mean_ms": round(sum(latencies) / len(latencies), 2) if latencies else None,
        "latency_p50_ms": percentile(latencies, 50),
        "latency_p95_ms": percentile(latencies, 95),
        "latency_max_ms": max(latencies) if latencies else None,
        "paths": dict(paths.most_common(10)),
        "error_examples": error_examples,
    }

def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("logfile", help="Path to a synthetic or authorized log file")
    parser.add_argument("--json", action="store_true", help="Print JSON")
    args = parser.parse_args(argv)
    path = Path(args.logfile)
    try:
        with path.open(encoding="utf-8", errors="replace") as handle:
            result = analyze_lines(handle)
    except OSError as exc:
        print(f"Cannot read {path}: {exc}", file=sys.stderr)
        return 2
    if args.json:
        print(json.dumps(result, indent=2, sort_keys=True))
    else:
        print(f"lines={result['lines']}")
        print(f"levels={result['levels']}")
        print(f"http_4xx={result['http_4xx']} http_5xx={result['http_5xx']} 5xx_rate={result['http_5xx_rate_percent']}%")
        print(f"latency_ms: samples={result['latency_samples']} mean={result['latency_mean_ms']} p50={result['latency_p50_ms']} p95={result['latency_p95_ms']} max={result['latency_max_ms']}")
        print(f"top_paths={result['paths']}")
        if result["error_examples"]:
            print("error_examples:")
            for line in result["error_examples"]:
                print(f"  {line}")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
