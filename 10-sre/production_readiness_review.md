# Production Readiness Review (PRR) checklist

Use this before a major launch or platform change. Mark `Yes`, `No`, `N/A` and attach evidence.

## Service and ownership
- [ ] A named team owns code, on-call, runbooks and dependency decisions.
- [ ] Critical user journeys and tier/severity are defined.
- [ ] Dependencies and fault domains are documented.

## Reliability targets and observability
- [ ] SLIs measure user outcomes, not just process health.
- [ ] SLO targets, windows and error-budget policy are agreed.
- [ ] Dashboards show latency, traffic, errors and saturation.
- [ ] Alerts are actionable, have an owner/runbook and tested paging path.
- [ ] Logs/traces have correlation IDs where useful and avoid sensitive data.

## Resilience and capacity
- [ ] Timeouts are explicit and aligned end-to-end.
- [ ] Retries are bounded, use backoff+jitter, and are safe/idempotent.
- [ ] Queues are bounded; overload behavior and load shedding are defined.
- [ ] Capacity and load tests cover growth, dependency failures and failover.
- [ ] Failure of one zone/region/dependency has a documented response.

## Delivery and changes
- [ ] CI checks include tests, lint/security checks as appropriate.
- [ ] Deployments use a progressive strategy and defined stop conditions.
- [ ] Rollback or forward-fix plan is tested, including schema/data compatibility.
- [ ] Config/secrets are versioned/managed safely; access is least privilege.
- [ ] Change owner, blast radius, validation and communication plan are clear.

## Operations and security
- [ ] Runbooks are tested by someone other than the author.
- [ ] Backup/restore, disaster recovery, RTO/RPO and data integrity have been tested where applicable.
- [ ] Certificate/credential rotation and expiry monitoring are in place.
- [ ] Resource requests/limits, autoscaling and quotas are understood.
- [ ] Incident roles and escalation path are documented.

## Exercise
Choose three unchecked items. Rank them by expected user impact, likelihood and mitigation cost. State what evidence would convince you each item is truly ready.
