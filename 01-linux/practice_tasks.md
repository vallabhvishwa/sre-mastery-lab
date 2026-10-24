# Linux practice tasks

Work sequentially; for each task record commands, relevant output, your explanation and one possible alternative cause. Do not run destructive exercises on shared/production machines.

## Files and permissions
1. Explain absolute vs relative paths, hidden files, globbing, `find`, `xargs` and quoting.
2. Create a scratch file, set `600`, `640` and `755`; explain owner/group/other and executable semantics.
3. Explain `>` vs `>>`, pipe exit codes, `2>&1` and why unquoted variables can break scripts.
4. Search sample logs for ERROR, group by status, extract request IDs and count unique failures.
5. Explain symlink vs hard link; use only temporary files under the repository’s ignored `data/` directory.

## Processes and resources
6. Explain PID/PPID, zombie, uninterruptible sleep, threads and signals.
7. Compare load average with CPU utilization and core count. Explain why high load does not prove CPU saturation.
8. Compare `MemAvailable`, free memory, page cache, swap and OOM-killer evidence.
9. Compare `df -h`, `df -i`, `du`; explain deleted-but-open file behavior.
10. Explain file descriptor exhaustion and how to inspect process limits without changing them.
11. Inspect systemd only where available; explain PID 1 and why containers often lack systemd.
12. Use `journalctl`, app logs and timestamps to build a timeline.

## Networking
13. Inspect `ip addr`, `ip route`, resolver configuration, `ss -lntup`.
14. Use `getent hosts example.com`; if allowed, `curl -v --max-time 4 https://example.com`.
15. Explain DNS failure vs TCP timeout vs connection refused vs TLS failure vs HTTP 5xx.
16. Trace a request through client → load balancer/proxy → service → DB. Identify where to measure each segment.

## Troubleshooting challenge
17. Given high latency, state 3 hypotheses and the evidence that distinguishes them.
18. Given a failing service, check recent changes, process, logs, socket, dependencies and resources before restarting.
19. Write a read-only diagnostic script that tolerates missing commands and restricted permissions.
20. Create a health-check script with a timeout and nonzero exit code on failure.

## Exit test
In 25 minutes, investigate one synthetic incident without using its case name as a clue. Explain the impact, evidence, competing hypotheses, lowest-risk test, mitigation, validation, and prevention.
