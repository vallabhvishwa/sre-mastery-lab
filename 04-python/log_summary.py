#!/usr/bin/env python3
"""Summarize simple line-oriented app logs; stdlib only."""
from __future__ import annotations
import argparse
import json
import re
import sys
from collections import Counter
from pathlib import Path

LEVEL_RE = re.compile(r"\b(DEBUG|INFO|WARN|WARNING|ERROR|CRITICAL)\b")
STATUS_RE = re.compile(r"\bstatus[=: ]+(\d{3})\b", re.I)
PATH_RE = re.compile(r"\bpath[=: ]+([^\s]+)", re.I)

def summarize(path: Path) -> dict:
    levels: Counter[str] = Counter()
    statuses: Counter[str] = Counter()
    paths: Counter[str] = Counter()
    total = 0
    malformed = 0
    with path.open("r", encoding="utf-8", errors="replace") as handle:
        for line in handle:
            total += 1
            level = LEVEL_RE.search(line)
            if level:
                levels[level.group(1)] += 1
            else:
                malformed += 1
            status = STATUS_RE.search(line)
            if status:
                statuses[status.group(1)] += 1
            endpoint = PATH_RE.search(line)
            if endpoint:
                paths[endpoint.group(1)] += 1
    return {"file": str(path), "total_lines": total, "lines_without_level": malformed,
            "levels": dict(levels), "http_statuses": dict(statuses),
            "top_paths": paths.most_common(10)}

def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("file", type=Path)
    args = parser.parse_args()
    if not args.file.is_file():
        print(f"error: not a regular file: {args.file}", file=sys.stderr)
        return 2
    try:
        print(json.dumps(summarize(args.file), indent=2))
    except OSError as exc:
        print(f"error: could not read file: {exc}", file=sys.stderr)
        return 2
    return 0

if __name__ == "__main__":
    sys.exit(main())
