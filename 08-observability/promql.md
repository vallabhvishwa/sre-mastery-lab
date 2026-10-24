# Observability and PromQL practice

Start with user-visible symptoms. Metrics should help answer: are requests succeeding, how long do they take, how much traffic is arriving, and where is saturation occurring?

## PromQL patterns (adapt metric names to the app/exporter)

```promql
# Per-second request rate
sum(rate(http_requests_total[5m]))

# Error ratio (example: 5xx / all requests)
sum(rate(http_requests_total{status=~"5.."}[5m])) / clamp_min(sum(rate(http_requests_total[5m])), 1e-9)

# p95 latency when a histogram exposes *_bucket
histogram_quantile(0.95, sum by (le) (rate(http_request_duration_seconds_bucket[5m])))

# Container memory vs limit (metric availability varies)
container_memory_working_set_bytes
```

Do not copy a query and assume it works: first inspect available metric names, label semantics, scrape interval, reset behavior and cardinality. Histograms should be aggregated correctly by `le`; client-side quantiles generally cannot be aggregated into a fleet quantile.

## Alert design checklist

- Alerts on user-impacting symptoms or a meaningful SLO burn, not every noisy cause metric.
- Has an owner, severity, clear description, runbook and actionable next step.
- Uses a duration/window appropriate to impact; avoid alerting on brief harmless spikes.
- Avoids high-cardinality labels such as request IDs, user IDs and full URLs.
- Has a tested delivery path and a clear escalation policy.

## Dashboard design

Top row: availability/success ratio, traffic, latency percentiles, saturation. Below: dependency health, resource pressure, deployment markers, logs/traces links. A graph without an operational question is decoration.
