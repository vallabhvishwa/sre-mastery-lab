# SRE system design interview framework

## Structure your answer

1. Clarify functional requirements and reliability goals.
2. Quantify traffic, payload size, concurrency, growth, retention, regions and RTO/RPO assumptions.
3. Sketch components and request/data flows.
4. Identify bottlenecks, single points of failure and dependency boundaries.
5. Discuss timeouts, retries with jitter, idempotency, circuit breakers, load shedding, bounded queues and backpressure.
6. Explain storage consistency/replication, failover, recovery and data-loss trade-offs.
7. Define SLI/SLO, alerts, dashboards, capacity tests and operational ownership.
8. Secure the system: identity, least privilege, secrets, encryption, audit and supply chain.
9. Deployment plan: progressive rollout, compatibility, rollback, canary evaluation and stop conditions.
10. State trade-offs and what you would test first.

## Practice prompts

- Global workforce/attendance API with regional failover.
- Internal Kubernetes platform serving 200 engineering teams.
- A deployment orchestrator that rolls out changes safely across clusters.
- Metrics ingestion service with high cardinality risk.
- Service that depends on a slow database and a flaky downstream API.
- Certificate rotation system with no downtime.
- Alerting platform where a monitoring outage must not hide a customer outage.

For each: state assumptions aloud, size orders of magnitude, draw failure domains, define one SLO, explain overload behavior and walk through a region/dependency failure.
