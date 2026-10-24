# Scenario catalogue

Attempt each with `runbooks/lab_report_template.md` before reading any solution notes. Use `./labctl.sh case <name>` for the synthetic log set when present.

- `http_5xx`: only one route is failing, other route remains healthy.
- `dns`: service discovery lookup fails.
- `dependency_latency`: downstream database calls are slow and gateway times out.
- `oom`: synthetic memory limit and restart clues.
- `disk_blocks`: synthetic filesystem block exhaustion/log-write failure clues.
- `disk_inodes`: inodes exhausted while block usage remains relatively low.
- `permissions`: permission/credential-file clues.
- `rollout_bad_config`: design-only Kubernetes rollout with invalid config.
- `retry_storm`: downstream latency and retry multiplication.
- `cpu_saturation`: rising traffic, run queue, latency and HTTP 503s.
- `bad_rollout`: new release has low readiness and elevated 503s.
- `queue_lag`: producer rate exceeds consumer processing rate.
- `clock_skew`: token validation/log ordering affected by time offset.
- `certificate_expiry`: TLS requests fail after certificate reaches expiry.
- `region_degradation`: multi-region capacity/traffic shift tabletop.

The synthetic log cases do not modify OS resources. More advanced scenarios are table-top exercises unless explicitly run in an isolated disposable lab.
