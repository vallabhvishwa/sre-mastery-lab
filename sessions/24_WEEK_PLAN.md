# 24-week SRE engineering curriculum

This is a progression, not a promise of mastery in 24 weeks. Target 5–7 one-hour labs per week when possible; repeat weak labs instead of rushing. One KodeKloud playground per session.

## Weeks 1–4: Linux, evidence and networking

### Week 1 — Linux observability
1. Ubuntu: environment inventory, filesystem layout, permissions, users/groups.
2. Ubuntu: processes, PID/PPID, signals, states, load average vs CPU.
3. Ubuntu: memory, RSS, swap, OOM clues, `free`, `/proc/meminfo`.
4. Ubuntu: disk blocks vs inodes, mount points, `du`, deleted-open file concept.
5. Ubuntu: systemd if available; otherwise understand container PID 1 limitations.
6. Rocky/CentOS: package/service/log differences; avoid destructive changes.
7. Review: 30-minute Linux incident from a synthetic brief, no hints.

### Week 2 — Logs, files and performance
1. `journalctl`, service logs, timestamps and timezone.
2. `grep`, `awk`, `sed`, `sort`, `uniq`, `cut`, `xargs` safely.
3. File descriptors, sockets, ulimits and process limits.
4. CPU: top processes, context switches basics, saturation evidence.
5. Memory: cache vs available memory, OOM evidence, avoid guessing from one graph.
6. Disk: iostat concepts, latency vs utilization, filesystem/inode pressure.
7. Review: explain a slow host with evidence and 2 hypotheses.

### Week 3 — Networking fundamentals
1. IP/subnet, route, gateway and DNS resolver configuration.
2. DNS: `getent`, `dig` if available, A/AAAA/CNAME, NXDOMAIN vs timeout.
3. TCP: listeners, SYN/refused/timeout, `ss`, `curl -v`.
4. TLS: certificate chain, hostname, expiry, SNI and handshake failure.
5. HTTP: status codes, redirects, headers, timeouts and retries.
6. Client→proxy→service→DB request path; identify where latency occurs.
7. Review: diagnose synthetic DNS vs connection failure without changing network state.

### Week 4 — Bash, Git and Python automation
1. Bash: quoting, positional args, exit codes, `set -euo pipefail` caveats.
2. Bash: robust health check, timeouts, structured output.
3. Git: branch, diff, commit, revert, merge conflict, clean working tree.
4. Python: data types, loops, functions, lists/dicts, exceptions.
5. Python: JSON, files, `argparse`, `logging`, HTTP timeout, return codes.
6. Python: unit tests and test doubles for API failures.
7. Review: complete one tool without tutorial; include README and tests.

## Weeks 5–8: OS operations, containers and release engineering

### Week 5 — Linux reliability operations
1. Startup/service dependency and readiness vs liveness.
2. Cron/systemd timers and job failure reporting.
3. Permissions and least privilege; diagnose without `chmod 777`.
4. Process leak / FD exhaustion reasoning (synthetic only if no safe reproducer).
5. Certificate/secret rotation concepts and expiry monitoring.
6. Runbook design: preconditions, steps, validation and rollback.
7. Review: write a repeatable investigation script that only reads state.

### Week 6 — Docker / container runtime
1. Image, container, layer, registry, tag and digest.
2. Dockerfile cache, non-root user, minimal base image, health checks.
3. Container logs, exit codes, restart behavior and environment.
4. Networks, ports, DNS and service reachability.
5. Volumes, persistence and database state; safe cleanup.
6. Image provenance, secrets, scanning and immutable tags.
7. Review: diagnose a container that exits immediately; avoid changing multiple variables.

### Week 7 — GitHub Actions / CI/CD
1. Workflow triggers, jobs, steps, runners and permissions.
2. `needs`, artifacts, caches, concurrency and matrix strategy.
3. Secrets, least-privilege `GITHUB_TOKEN`, injection risks and third-party actions.
4. Build/test a small Python or PetClinic component.
5. Container build/publish workflow; use a non-sensitive test registry or mock.
6. Environments, required approvals, rollback and release verification.
7. Review: break a workflow on a branch, inspect logs, fix, revert and document.

### Week 8 — Deployment safety and GitOps
1. Rolling vs blue/green vs canary and failure trade-offs.
2. Readiness probes and traffic gating.
3. Change plan: blast radius, prechecks, stop conditions, rollback triggers.
4. Flux/ArgoCD reconciliation model; drift and desired state.
5. Deployment validation and smoke tests.
6. Release incident: bad image/config; use a disposable branch/namespace.
7. Review: deploy a change with measurable success and rollback criteria.

## Weeks 9–12: Kubernetes core and debugging

### Week 9 — Kubernetes architecture
1. API server, scheduler, controllers, etcd and kubelet responsibilities.
2. Pods, Deployments, ReplicaSets and rollout history.
3. Services, selectors, endpoints and DNS.
4. Requests/limits, QoS classes and OOMKilled.
5. ConfigMaps, Secrets, service accounts and RBAC.
6. Events, `describe`, logs, previous logs, rollout status.
7. Review: explain a Pending pod using events and scheduler evidence.

### Week 10 — Kubernetes troubleshooting
1. CrashLoopBackOff: command, config, dependency, probe, permission.
2. ImagePullBackOff: tag, registry auth, network, architecture.
3. Service unreachable: selector/endpoints, port/targetPort, policy, app bind.
4. DNS issue: CoreDNS, policy, name, cluster versus external lookup.
5. OOM / CPU throttling: limits, working set, concurrency and profile clues.
6. Node NotReady / scheduling: taints, tolerations, capacity, conditions.
7. Review: 30-minute cluster incident, written findings and recovery validation.

### Week 11 — Advanced cluster operations
1. HPA metrics and scaling behavior.
2. PDB and node drain / upgrade planning.
3. NetworkPolicies and least privilege.
4. Ingress/Gateway and TLS routing.
5. Stateful workloads, PV/PVC and storage binding.
6. Cluster upgrade: compatibility, disruption and rollback limits.
7. Review: create an upgrade implementation + validation plan.

### Week 12 — Helm and platform ecosystem
1. Helm chart values, templates and releases.
2. Rollback, revisions and configuration drift.
3. Kustomize overlays and environment separation.
4. Rancher concepts and multi-cluster control.
5. Istio: sidecars, gateways, retries, timeout and circuit-breaking concepts.
6. NGINX ingress/reverse proxy and 502/504 reasoning.
7. Review: diagnose a mesh/proxy timeout using layered evidence.

## Weeks 13–16: Observability and core SRE

### Week 13 — Monitoring
1. Golden signals: latency, traffic, errors, saturation.
2. Prometheus targets, scrape, labels and cardinality.
3. PromQL: rates, ratios, histograms and quantiles.
4. Grafana panels, useful time ranges and correlation.
5. Logs vs metrics vs traces; when each helps.
6. Alert quality: symptom, actionable, owner, runbook, severity.
7. Review: design a dashboard for user-facing reliability.

### Week 14 — SLO and error budgets
1. Choose a user-relevant SLI and good event denominator.
2. Availability/error-ratio SLO and window selection.
3. Calculate allowed bad events and remaining error budget.
4. Burn rate and why short+long windows reduce noisy alerts.
5. Dependency SLOs, critical user journeys and partial failures.
6. Release policy tied to budget—avoid treating SLO as an arbitrary uptime number.
7. Review: submit a one-page SLO doc plus an alert/runbook.

### Week 15 — Incident response and P0 leadership
1. Severity, impact statement, incident declaration and timeline.
2. Roles: Incident Commander, Ops/Tech Lead, Communications Lead, subject experts.
3. Status updates: known/unknown, user impact, action, next update time.
4. Mitigate vs diagnose; criteria for rollback, traffic shift, disable feature.
5. Handoffs, fatigue, parallel workstreams, decision log.
6. Recovery validation and monitoring for recurrence.
7. Review: run a simulated P0 tabletop without changing any real system.

### Week 16 — Postmortems and toil
1. Timeline reconstructed from evidence.
2. Root vs contributing factors; blameless analysis.
3. Detection gap and time-to-detect / time-to-mitigate.
4. Write useful action items: owner, due date, measurable result.
5. Toil inventory and automate only repeatable understood work.
6. Production readiness review: capacity, rollback, observability, security, ownership.
7. Review: present a postmortem and defend prevention priorities.

## Weeks 17–20: distributed systems, scale and cloud

### Week 17 — Distributed systems failure modes
1. Partial failure, timeouts and ambiguous outcomes.
2. Retries, exponential backoff, jitter, retry budgets and retry storms.
3. Idempotency keys and safe retry semantics.
4. Circuit breakers, bulkheads, queue limits and load shedding.
5. Consistency, replication lag, leader election and quorum concepts.
6. Cascading failures and dependency graphs.
7. Review: design a resilient request path with a strict latency budget.

### Week 18 — Capacity and performance
1. Little's Law and queueing intuition.
2. Capacity estimates from traffic, concurrency and service time.
3. Load test design: representative mix, baseline, saturation, stop criteria.
4. CPU/memory/network/disk bottleneck isolation.
5. Autoscaling lag, cold starts and capacity headroom.
6. Cache hit rate, thundering herd and stampede protection.
7. Review: write capacity assumptions and failure thresholds.

### Week 19 — Terraform and Ansible
1. Terraform init/plan/apply, providers, variables and outputs.
2. State, locking, remote backend, drift and import concepts.
3. Module boundaries and secure state/secret handling.
4. Ansible inventory, SSH, modules and ad-hoc commands.
5. Playbooks, idempotency, handlers, templates, variables and roles.
6. `--check`, `--diff`, syntax validation and Ansible Vault concepts.
7. Review: automate a safe change on two disposable targets.

### Week 20 — GCP, Azure and private cloud
1. Map Azure concepts to GCP: subscription/resource group vs project/folder.
2. IAM, service accounts, least privilege and workload identity concepts.
3. VPC, subnet, routes, firewall, DNS and load balancing.
4. GKE, Artifact Registry, Cloud Logging/Monitoring; stay within sandbox limits.
5. Workload Identity Federation for external CI/CD, if lab access permits.
6. OpenStack service vocabulary; identify compute/network/storage responsibility.
7. Review: architecture diagram and access/deployment troubleshooting story.

## Weeks 21–24: software engineering and Google-level interview practice

### Week 21 — Data structures and algorithms
1. Big-O: time/space and trade-offs.
2. Arrays/strings, hash maps and sets.
3. Stack, queue, two pointers and sliding window.
4. Binary search and sorting.
5. Trees/graphs basics, BFS/DFS.
6. Heap/top-k, intervals or simple scheduling problem.
7. Review: solve 2 problems with tests and explain complexity.

### Week 22 — Programming for operations
1. Python: CLI, config, JSON, timeouts and exit codes.
2. Python: requests, pagination, API error handling and retries.
3. Python: `logging`, exceptions, unit tests, mocks.
4. Go basics: structs, interfaces, errors and modules.
5. Go: HTTP client/server, context deadline and graceful shutdown.
6. Go: goroutines/channels safely; race and leak concepts.
7. Review: build a tested, documented health-check utility.

### Week 23 — SRE system design
1. Design a highly available API for a global workload.
2. Design rate limiting, overload protection and fair queuing.
3. Design telemetry pipeline and avoid high-cardinality metrics.
4. Design deployment/rollback service with authorization and auditability.
5. Design multi-region failover; discuss RTO/RPO and data consistency.
6. Design certificate/secret rotation without outage.
7. Review: 45-minute design interview; state assumptions and failure modes.

### Week 24 — Game days and readiness assessment
1. Linux/resource exhaustion tabletop.
2. Network/DNS/TLS incident tabletop.
3. Kubernetes rollout / dependency incident.
4. CI/CD bad release and rollback.
5. Regional/dependency outage and load-shedding design.
6. Lead a P0 simulation with communications and incident log.
7. Review scorecard; repeat the weakest two areas next week.

## Every week has a gate

Do not mark a week complete because the videos are watched. Complete its review session with no hints, explain evidence, validate recovery, and commit a lab report. If score is under 3/4, repeat a related exercise before advancing.

## Ongoing engineering practice (in parallel with every week)

For Google-level SRE interviews, the 24-week plan is a foundation, not enough by itself. In addition to the weekly one-hour playground sessions, schedule **three 30–45 minute coding/problem-solving sessions per week** outside the playground when possible:

- One coding problem: arrays/strings/hash maps/sets/stack/queue, with tests and Big-O explanation.
- One programming task: build/refactor/test an automation utility in Python, then read or implement a small equivalent in Go when relevant.
- One system-design / incident reasoning prompt: state assumptions, draw the dependency graph, list failure modes, capacity, SLO, mitigation and trade-offs.

Maintain a spaced-repetition list of mistakes. Re-solve a problem without notes a week later. Prioritise understanding over counting problems solved.
