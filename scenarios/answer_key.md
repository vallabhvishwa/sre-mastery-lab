# Instructor notes / answer key — read after attempting

## http_5xx
- Impact: `/owners` / customers path fails; `/vets` healthy suggests partial rather than total gateway outage.
- Hypotheses: customers service slow/unhealthy; gateway upstream timeout/config; dependency/database bottleneck.
- Evidence: correlate request IDs, gateway upstream logs, customers logs, dependency timing, readiness and recent deploys.
- Mitigation: rollback only if correlated to a change; otherwise route/disable affected path or fix downstream after evidence.

## dns
- Distinguish resolver unable to resolve name from service absent/wrong namespace, registration failure or wrong hostname. Test resolution from the caller context, inspect discovery health and registrations.

## dependency_latency
- Check downstream latency, pool saturation, DB health, concurrency and queue depth. Adding retries without a budget can worsen overload. Use bounded timeouts, controlled retry/backoff, load shedding and recovery validation.

## oom
- Synthetic log only: compare working set to configured limit and restart evidence. In a real container, inspect exit code/last termination state/events, metrics and historical traffic; raising limits blindly can move pressure to the node.

## disk_blocks
- Synthetic log indicates block exhaustion. Confirm with `df -h`, identify the affected mount and find large writers safely. Distinguish it from inode exhaustion (`df -i`) and deleted-open files. In real systems do not `rm -rf` or truncate blindly.

## permissions
- Avoid `chmod 777`. Check user/group, path traversal permissions, executable bit and secret file ownership. Grant least privilege and validate runner identity.

## retry_storm
- Retries multiply load when a dependency is already failing. Use retry budgets, jittered exponential backoff, request deadlines, idempotency, circuit breakers and load shedding; recover gradually.

## certificate_expiry
- Check actual clock, hostname/SNI, chain/trust, certificate dates and which hop terminates TLS. Restore valid cert through the approved rotation mechanism; don't disable TLS verification.

## region_degradation
- First measure affected traffic/capacity; traffic shift may overload the surviving region. Confirm failover readiness, data consistency, dependencies and rollback plan before moving all traffic.

## disk_inodes
- Disk block usage and inode usage are different. A filesystem can have free bytes but no free inodes when many small files exist.
- Evidence: compare `df -h` with `df -i`; find the responsible directory/file population safely. Do not delete files blindly.

## certificate
- Verify the clock, actual certificate validity dates, hostname/SNI, trust chain, and which layer terminates TLS. Rotate through the approved path; don't disable validation.

## cpu_saturation
- Correlate increasing traffic with CPU busy/run queue, p95 latency and 5xx. Confirm CPU saturation using multiple signals; consider hot code path, lock contention, throttling, insufficient replicas or a traffic spike. Mitigate load or roll back only with evidence.

## bad_rollout
- New revision has low ready replicas and elevated 503. Inspect rollout events, pod logs, readiness failures, config/image diff and timing. Stop/rollback the rollout in a disposable lab if release causality is supported; verify user-facing SLI afterward.

## queue_lag
- Producer publish rate exceeds consumer processing rate, so lag accumulates. Check consumer errors, rebalances, partition parallelism, downstream bottleneck and poison messages. Scaling consumers only helps if partitions and dependency capacity permit it.

## clock_skew
- A node's clock is substantially offset, causing token validity errors and incorrect event ordering. Check NTP/time sync, timestamp source and skew across nodes; restore time synchronization through the environment's approved service and confirm token validation and logs recover.
