#!/usr/bin/env python3
"""Calculate request-based SLO error budget and observed burn rate."""
import argparse
import json
import sys


def calculate(total: int, bad: int, slo_percent: float) -> dict:
    if total <= 0:
        raise ValueError("total requests must be greater than zero")
    if bad < 0 or bad > total:
        raise ValueError("bad requests must be between 0 and total")
    if not 0 < slo_percent <= 100:
        raise ValueError("SLO percent must be > 0 and <= 100")
    allowed_ratio = 1 - slo_percent / 100
    observed_ratio = bad / total
    allowed_bad = total * allowed_ratio
    remaining = allowed_bad - bad
    burn = (observed_ratio / allowed_ratio) if allowed_ratio > 0 else (0 if bad == 0 else float("inf"))
    return {
        "eligible_requests": total,
        "bad_requests": bad,
        "slo_percent": slo_percent,
        "observed_error_ratio_percent": round(observed_ratio * 100, 6),
        "allowed_bad_requests_for_this_volume": round(allowed_bad, 3),
        "remaining_budget_requests": round(remaining, 3),
        "budget_exhausted": remaining < 0,
        "burn_rate_vs_average_slo_allowance": round(burn, 4) if burn != float("inf") else "infinite",
        "note": "Request-based model. Do not mix request budget units with time-based availability budgets."
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--total", type=int, required=True, help="eligible request count")
    parser.add_argument("--bad", type=int, required=True, help="bad request count")
    parser.add_argument("--slo", type=float, required=True, help="SLO percentage, e.g. 99.9")
    args = parser.parse_args()
    try:
        print(json.dumps(calculate(args.total, args.bad, args.slo), indent=2))
    except ValueError as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 2
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
